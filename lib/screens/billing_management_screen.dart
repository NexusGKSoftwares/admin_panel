import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BillingManagementScreen extends StatefulWidget {
  const BillingManagementScreen({Key? key}) : super(key: key);

  @override
  _BillingManagementScreenState createState() => _BillingManagementScreenState();
}

class _BillingManagementScreenState extends State<BillingManagementScreen> {
  List<Map<String, dynamic>> allBills = [];
  List<Map<String, dynamic>> displayedBills = [];
  String currentFilter = 'All';

  @override
  void initState() {
    super.initState();
    fetchBillsFromBackend();
  }

  Future<void> fetchBillsFromBackend() async {
    try {
      final response = await http.get(Uri.parse('http://localhost/pure/get_all_bills.php'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data["success"] == true && data["bills"] is List) {
          setState(() {
            allBills = List<Map<String, dynamic>>.from(data["bills"]);
            displayedBills = List.from(allBills);
          });
        } else {
          print("No bills available or data format invalid.");
        }
      } else {
        print("Failed to load bills. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred while fetching bills: $e");
    }
  }

  void _filterBills(String filter) {
    setState(() {
      currentFilter = filter;
      if (filter == 'Paid') {
        displayedBills = allBills.where((bill) => bill['payment_status'] == 'paid').toList();
      } else if (filter == 'Unpaid') {
        displayedBills = allBills.where((bill) => bill['payment_status'] == 'unpaid').toList();
      } else {
        displayedBills = List.from(allBills);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing Management'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterOptions(),
            const SizedBox(height: 20),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: _buildBillingList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () => _filterBills('Unpaid'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
          ),
          child: const Text('Unpaid Bills'),
        ),
        ElevatedButton(
          onPressed: () => _filterBills('Paid'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text('Paid Bills'),
        ),
        ElevatedButton(
          onPressed: () => _filterBills('All'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
          ),
          child: const Text('All Bills'),
        ),
      ],
    );
  }

  Widget _buildBillingList() {
    return ListView.builder(
      key: ValueKey<String>(currentFilter), // Unique key for AnimatedSwitcher
      itemCount: displayedBills.length,
      itemBuilder: (context, index) {
        final bill = displayedBills[index];
        return _buildBillingCard(
          user: bill['name'] ?? bill['user'] ?? 'Unknown User',
          amountDue: bill['amount_due'],
          status: bill['payment_status'],
          dueDate: bill['due_date'],
        );
      },
    );
  }

  Widget _buildBillingCard({
    required String user,
    required String amountDue,
    required String status,
    required String dueDate,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: status == 'paid' ? Colors.green : Colors.redAccent,
          child: Icon(
            status == 'paid' ? Icons.check_circle : Icons.warning,
            color: Colors.white,
          ),
        ),
        title: Text(user, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Amount Due: Kshs. $amountDue\nDue Date: $dueDate'),
        trailing: ElevatedButton(
          onPressed: () {
            // TODO: Handle mark as paid functionality here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: status == 'paid' ? Colors.green : Colors.redAccent,
          ),
          child: Text(status == 'paid' ? 'Paid' : 'Mark as Paid'),
        ),
      ),
    );
  }
}
