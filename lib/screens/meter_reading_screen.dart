import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MeterReadingScreen extends StatefulWidget {
  const MeterReadingScreen({Key? key}) : super(key: key);

  @override
  _MeterReadingScreenState createState() => _MeterReadingScreenState();
}

class _MeterReadingScreenState extends State<MeterReadingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _previousReadingController = TextEditingController();
  final TextEditingController _currentReadingController = TextEditingController();
  bool _isSubmitting = false;
  String? selectedUserId;
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    const usersApiUrl = 'http://your-backend-url/get_users.php'; // Adjust to your endpoint

    try {
      final response = await http.get(Uri.parse(usersApiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          users = List<Map<String, dynamic>>.from(data['users']);
        });
      } else {
        _showMessage('Error', 'Failed to load users');
      }
    } catch (e) {
      _showMessage('Error', 'An error occurred while fetching users');
    }
  }

  Future<void> _submitReading() async {
    if (_formKey.currentState?.validate() ?? false && selectedUserId != null) {
      setState(() => _isSubmitting = true);

      const apiUrl = 'http://your-backend-url/generate_bill.php';
      final data = {
        'userId': selectedUserId,
        'previous_reading': _previousReadingController.text,
        'current_reading': _currentReadingController.text,
        'reading_date': DateTime.now().toIso8601String(),
      };

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          body: data,
        );

        final responseData = json.decode(response.body);
        setState(() => _isSubmitting = false);

        if (response.statusCode == 200 && responseData['success'] == true) {
          _showMessage('Success', 'Bill generated successfully for the user.');
        } else {
          _showMessage('Failed', responseData['message'] ?? 'An error occurred.');
        }
      } catch (error) {
        setState(() => _isSubmitting = false);
        _showMessage('Error', 'Failed to submit the readings. Please try again.');
      }
    } else {
      _showMessage('Error', 'Please select a user and fill in all fields.');
    }
  }

  void _showMessage(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Meter Reading'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select User:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                value: selectedUserId,
                items: users
                    .map((user) => DropdownMenuItem(
                          value: user['id'].toString(),
                          child: Text(user['name']), // Adjust based on user data
                        ))
                    .toList(),
                onChanged: (value) => setState(() => selectedUserId = value),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null ? 'Please select a user' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _previousReadingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Previous Reading',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.history),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the previous reading';
                  }
                  final reading = int.tryParse(value);
                  if (reading == null || reading < 0) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _currentReadingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Current Reading',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.speed),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the current reading';
                  }
                  final reading = int.tryParse(value);
                  if (reading == null || reading < 0) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _isSubmitting
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _submitReading,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          ),
                          child: const Text(
                            'Generate Bill',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
