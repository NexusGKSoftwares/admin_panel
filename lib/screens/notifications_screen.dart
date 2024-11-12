import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<String> notifications = [
    "Meter reading submitted by User ID: 101",
    "Payment received from User ID: 102",
    "Reminder: Unpaid bills for User ID: 103",
    "User ID: 104 reported a fault in the system",
    "Meter reading overdue for User ID: 105",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return _buildNotificationCard(notifications[index]);
        },
      ),
    );
  }

  Widget _buildNotificationCard(String notification) {
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
            notification,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            onPressed: () {
              setState(() {
                notifications.remove(notification);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Notification dismissed"),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
