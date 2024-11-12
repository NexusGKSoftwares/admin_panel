import 'package:flutter/material.dart';

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
      
      // Mock API call for demonstration, replace with real API call
      await Future.delayed(const Duration(seconds: 2)); 

      setState(() => _isSubmitting = false);
      
      // Show confirmation
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Meter Reading Submitted'),
          content: const Text('Your meter reading has been successfully submitted.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
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
