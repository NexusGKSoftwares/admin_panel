import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Pure Water Admin Panel',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildOverviewCards(),
            SizedBox(height: 20),
            _buildQuickActions(context),
          ],
        ),
      ),
    );
  }

  // Dashboard Overview Cards
  Widget _buildOverviewCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard('Total Users', '120', Colors.blue),
        _buildStatCard('Pending Bills', '30', Colors.red),
        _buildStatCard('Recent Payments', '15', Colors.green),
      ],
    );
  }

  Widget _buildStatCard(String title, String count, Color color) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 10),
            Text(count, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // Quick Action Buttons
  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildActionButton(context, 'Manage Bills', Icons.receipt_long, Colors.orange, '/billingManagement'),
            _buildActionButton(context, 'Meter Readings', Icons.speed, Colors.blue, '/meterReading'),
            _buildActionButton(context, 'User Management', Icons.people, Colors.purple, '/userManagement'),
            _buildActionButton(context, 'Send Notifications', Icons.notifications, Colors.green, '/notifications'),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, String label, IconData icon, Color color, String route) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }
}
