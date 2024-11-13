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
  final TextEditingController _currentReadingController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submitReading() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isSubmitting = true);

      // Replace with your backend API URL
      const apiUrl = 'http://your-backend-url/generate_bill.php';

      // Prepare request data
      final Map<String, String> data = {
        'userId': '1', // Replace with actual user ID
        'previous_reading': '150', // Replace with actual previous reading
        'current_reading': _currentReadingController.text,
        'reading_date': DateTime.now().toString(), // Or your required date format
      };

      try {
        // Make the POST request
        final response = await http.post(
          Uri.parse(apiUrl),
          body: data,
        );

        // Handle response
        final responseData = json.decode(response.body);
        setState(() => _isSubmitting = false);

        if (response.statusCode == 200 && responseData['success'] == true) {
          _showMessage('Meter Reading Submitted', 'Your meter reading has been successfully submitted.');
        } else {
          _showMessage('Submission Failed', responseData['message'] ?? 'An error occurred.');
        }
      } catch (error) {
        setState(() => _isSubmitting = false);
        _showMessage('Error', 'Failed to submit the reading. Please try again.');
      }
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
        title: const Text('Submit Meter Reading'),
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
                'Enter your current meter reading:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                            'Submit Reading',
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
