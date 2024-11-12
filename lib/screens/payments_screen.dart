import 'package:flutter/material.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({Key? key}) : super(key: key);

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final List<Map<String, dynamic>> payments = [
    {
      "userId": "101",
      "amount": "Kshs. 200.00",
      "method": "M-Pesa",
      "status": "Completed",
      "date": "Nov 10, 2024"
    },
    {
      "userId": "102",
      "amount": "Kshs. 150.00",
      "method": "Bank Transfer",
      "status": "Pending",
      "date": "Nov 9, 2024"
    },
    {
      "userId": "103",
      "amount": "Kshs. 250.00",
      "method": "Credit Card",
      "status": "Failed",
      "date": "Nov 8, 2024"
    },
  ];

  String selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payments Management"),
        backgroundColor: Colors.blueAccent,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                selectedFilter = value;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: "All",
                child: Text("All"),
              ),
              const PopupMenuItem<String>(
                value: "Completed",
                child: Text("Completed"),
              ),
              const PopupMenuItem<String>(
                value: "Pending",
                child: Text("Pending"),
              ),
              const PopupMenuItem<String>(
                value: "Failed",
                child: Text("Failed"),
              ),
            ],
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: payments
              .where((payment) => selectedFilter == "All" || payment["status"] == selectedFilter)
              .map((payment) => _buildPaymentCard(payment))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> payment) {
    Color statusColor;
    switch (payment["status"]) {
      case "Completed":
        statusColor = Colors.green;
        break;
      case "Pending":
        statusColor = Colors.orange;
        break;
      case "Failed":
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: ListTile(
        leading: Icon(
          Icons.payment,
          color: Colors.blueAccent.shade700,
          size: 30,
        ),
        title: Text(
          "User ID: ${payment['userId']}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Amount: ${payment['amount']}"),
            Text("Method: ${payment['method']}"),
            Text("Date: ${payment['date']}"),
          ],
        ),
        trailing: Text(
          payment["status"],
          style: TextStyle(
            color: statusColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
