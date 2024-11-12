import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.blueAccent, // Primary color
      ),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildOverviewCards(context),
              const SizedBox(height: 20),
              _buildRecentActivitySection(),
            ],
          ),
        ),
      ),
    );
  }

  // Build the overview section with refined cards
  Widget _buildOverviewCards(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCard('Total Users', '350', Colors.blueAccent),
            _buildCard('Active Users', '280', Colors.teal),
            _buildCard('Total Bills', '1000', Colors.orangeAccent),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCard('Unpaid Bills', '500', Colors.redAccent),
            _buildCard('Total Payments', '1500', Colors.purpleAccent),
            _buildCard('Reports', '80', Colors.amber),
          ],
        ),
      ],
    );
  }

  // Refined card style
  Widget _buildCard(String title, String value, Color iconColor) {
    return Container(
      width: 100,
      height: 120,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.circle, color: iconColor, size: 24),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }

  // Build recent activity section
  Widget _buildRecentActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        _buildRecentActivityItem('New User Registered', 'John Doe'),
        _buildRecentActivityItem('Bill Generated', 'User123'),
        _buildRecentActivityItem('Payment Received', 'User456'),
        _buildRecentActivityItem('Meter Reading Added', 'User789'),
      ],
    );
  }

  // Recent activity item
  Widget _buildRecentActivityItem(String action, String user) {
    return ListTile(
      leading: const Icon(Icons.notification_important, color: Colors.blueAccent),
      title: Text(action, style: const TextStyle(color: Colors.black87)),
      subtitle: Text('User: $user', style: TextStyle(color: Colors.grey[600])),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
      onTap: () {
        // Navigate to the details page (add navigation here)
      },
    );
  }

  // Drawer with refined color scheme
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Admin Name'),
            accountEmail: Text('admin@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.admin_panel_settings, color: Colors.blueAccent, size: 40),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle, color: Colors.blueAccent),
            title: const Text('Users', style: TextStyle(color: Colors.black87)),
            onTap: () {
              // Navigate to Users page (add navigation here)
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment, color: Colors.blueAccent),
            title: const Text('Bills', style: TextStyle(color: Colors.black87)),
            onTap: () {
              // Navigate to Bills page (add navigation here)
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.blueAccent),
            title: const Text('Settings', style: TextStyle(color: Colors.black87)),
            onTap: () {
              // Navigate to Settings page (add navigation here)
            },
          ),
        ],
      ),
    );
  }
}
