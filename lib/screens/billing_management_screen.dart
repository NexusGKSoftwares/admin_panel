import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BillingManagementScreen extends StatefulWidget {
  const BillingManagementScreen({Key? key}) : super(key: key);

  @override
  _BillingManagementScreenState createState() =>
      _BillingManagementScreenState();
}

class _BillingManagementScreenState extends State<BillingManagementScreen> {
  List<Map<String, dynamic>> allBills = [];
  List<Map<String, dynamic>> displayedBills = [];
  String currentFilter = 'All';

  @override
  void initState() {
    super.initState();
    _fetchBills();  // Fetch bills when the screen is loaded
  }

  // Function to fetch bills from the API
  Future<void> _fetchBills() async {
    final response = await http.get(Uri.parse('http://localhost/pure/get_user_bill.php'));
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      
      if (data['success'] == true) {
        setState(() {
          allBills = List<Map<String, dynamic>>.from(data['bills']);
          displayedBills = List.from(allBills);  // Initially display all bills
        });
      }
    } else {
      // Handle error if the request fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load bills")),
      );
    }
  }

  // Function to filter bills based on the status
  void _filterBills(String filter) {
    setState(() {
      currentFilter = filter;
      if (filter == 'Paid') {
        displayedBills = allBills.where((bill) => bill['payment_status'] == 'paid').toList();
      } else if (filter == 'Unpaid') {
        displayedBills = allBills.where((bill) => bill['payment_status'] == 'unpaid').toList();
      } else {
        displayedBills = List.from(allBills);  // Display all bills
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

  // Build filter options for Paid, Unpaid, and All bills
  Widget _buildFilterOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () => _filterBills('Unpaid'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
          ),
          child: const Text('Unpaid'),
        ),
        ElevatedButton(
          onPressed: () => _filterBills('Paid'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text('Paid'),
        ),
        ElevatedButton(
          onPressed: () => _filterBills('All'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
          ),
          child: const Text('All'),
        ),
      ],
    );
  }

  // Build list of displayed bills
  Widget _buildBillingList() {
    return ListView.builder(
      key: ValueKey<String>(currentFilter), // Unique key for AnimatedSwitcher
      itemCount: displayedBills.length,
      itemBuilder: (context, index) {
        final bill = displayedBills[index];
        return _buildBillingCard(bill['user'], bill['amount_due'], bill['payment_status']);
      },
    );
  }

  // Build each billing card for a user
  Widget _buildBillingCard(String? user, double? amount, String? status) {
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
        title: Text(user ?? 'Unknown User', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Amount: Kshs.${amount?.toStringAsFixed(2) ?? '0.00'}'),
        trailing: ElevatedButton(
          onPressed: () {
            // TODO: Mark as paid or view details
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: status == 'paid' ? Colors.green : Colors.redAccent,
          ),
          child: Text(status == 'paid' ? 'Paid' : 'Mark as Paid'),
        ),
        onTap: () {
          // TODO: Show detailed bill information
        },
      ),
    );
  }
}
