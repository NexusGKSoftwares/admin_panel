import 'package:flutter/material.dart';

class BillingManagementScreen extends StatefulWidget {
  const BillingManagementScreen({Key? key}) : super(key: key);

  @override
  _BillingManagementScreenState createState() =>
      _BillingManagementScreenState();
}

class _BillingManagementScreenState extends State<BillingManagementScreen> {
  List<Map<String, dynamic>> allBills = [
    {'user': 'John Doe', 'amount': 150.75, 'status': 'Unpaid'},
    {'user': 'Jane Smith', 'amount': 85.50, 'status': 'Paid'},
    {'user': 'Bob Johnson', 'amount': 120.30, 'status': 'Unpaid'},
  ];

  List<Map<String, dynamic>> displayedBills = [];
  String currentFilter = 'All';

  @override
  void initState() {
    super.initState();
    displayedBills = List.from(allBills);
  }

  void _filterBills(String filter) {
    setState(() {
      currentFilter = filter;
      if (filter == 'Paid') {
        displayedBills = allBills.where((bill) => bill['status'] == 'Paid').toList();
      } else if (filter == 'Unpaid') {
        displayedBills = allBills.where((bill) => bill['status'] == 'Unpaid').toList();
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
        return _buildBillingCard(bill['user'], bill['amount'], bill['status']);
      },
    );
  }

  Widget _buildBillingCard(String? user, double? amount, String? status) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: status == 'Paid' ? Colors.green : Colors.redAccent,
          child: Icon(
            status == 'Paid' ? Icons.check_circle : Icons.warning,
            color: Colors.white,
          ),
        ),
        title: Text(user ?? 'Unknown User', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Amount: \$${amount?.toStringAsFixed(2) ?? '0.00'}'),
        trailing: ElevatedButton(
          onPressed: () {
            // TODO: Mark as paid or view details
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: status == 'Paid' ? Colors.green : Colors.redAccent,
          ),
          child: Text(status == 'Paid' ? 'Paid' : 'Mark as Paid'),
        ),
        onTap: () {
          // TODO: Show detailed bill information
        },
      ),
    );
  }
}
