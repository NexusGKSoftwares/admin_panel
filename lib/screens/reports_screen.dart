import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  String selectedReportType = "Billing Report";

  List<Map<String, String>> reportData = [
    {"type": "Billing", "date": "2024-11-10", "amount": "Kshs. 200.00"},
    {"type": "Payment", "date": "2024-11-09", "amount": "Kshs. 150.00"},
    {"type": "Usage", "date": "2024-11-08", "units": "300 m³"},
  ];

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reports"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: () => _selectDateRange(context),
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                selectedReportType = value;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(value: "Billing Report", child: Text("Billing Report")),
              const PopupMenuItem<String>(value: "Payment Report", child: Text("Payment Report")),
              const PopupMenuItem<String>(value: "Usage Report", child: Text("Usage Report")),
            ],
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _startDate != null && _endDate != null
                ? Text(
                    "Date Range: ${DateFormat.yMMMd().format(_startDate!)} - ${DateFormat.yMMMd().format(_endDate!)}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                : const Text("Select a date range", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: reportData
                    .where((report) => report["type"]!.contains(selectedReportType.split(' ')[0]))
                    .map((report) => _buildReportCard(report))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(Map<String, String> report) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: ListTile(
        leading: Icon(
          Icons.insert_chart,
          color: Colors.blueAccent.shade700,
          size: 30,
        ),
        title: Text(
          "${report['type']} Report",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Date: ${report['date']}"),
        trailing: Text(
          report.containsKey("amount") ? "Amount: ${report['amount']}" : "Units: ${report['units']}",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
