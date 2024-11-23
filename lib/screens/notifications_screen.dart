import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<dynamic> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNotifications();
    // Poll the server every 10 seconds
    Future.delayed(const Duration(seconds: 10), () {
      fetchNotifications();
    });
  }

  Future<void> fetchNotifications() async {
    try {
      final response = await http.get(
        Uri.parse('https://example.com/api/notifications'), // Replace with your API endpoint
      );

      if (response.statusCode == 200) {
        setState(() {
          notifications = json.decode(response.body)['notifications'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching notifications: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.blueAccent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : notifications.isEmpty
              ? const Center(child: Text("No notifications available"))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return _buildNotificationCard(notifications[index]);
                  },
                ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: Colors.blueAccent.shade100,
        elevation: 4,
        borderRadius: BorderRadius.circular(10),
        child: ListTile(
          leading: Icon(
            Icons.notifications,
            color: Colors.blueAccent.shade700,
          ),
          title: Text(
            notification['message'],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            notification['created_at'],
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
