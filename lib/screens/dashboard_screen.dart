// dashboard_screen.dart
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.blueAccent,
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

  // Build the overview section with animated cards
  Widget _buildOverviewCards(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAnimatedCard('Total Users', '350', Colors.blue),
            _buildAnimatedCard('Active Users', '280', Colors.green),
            _buildAnimatedCard('Total Bills', '1000', Colors.orange),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAnimatedCard('Unpaid Bills', '500', Colors.red),
            _buildAnimatedCard('Total Payments', '1500', Colors.purple),
            _buildAnimatedCard('Reports', '80', Colors.yellow),
          ],
        ),
      ],
    );
  }

  // Animated card with scale effect
  Widget _buildAnimatedCard(String title, String value, Color color) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      width: 100,
      height: 120,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // Changes the position of the shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Build the recent activity section
  Widget _buildRecentActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildRecentActivityItem('New User Registered', 'John Doe'),
        _buildRecentActivityItem('Bill Generated', 'User123'),
        _buildRecentActivityItem('Payment Received', 'User456'),
        _buildRecentActivityItem('Meter Reading Added', 'User789'),
      ],
    );
  }

  // Build a recent activity item
  Widget _buildRecentActivityItem(String action, String user) {
    return ListTile(
      leading: const Icon(Icons.notification_important, color: Colors.blue),
      title: Text(action),
      subtitle: Text('User: $user'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Navigate to the details page (add navigation here)
      },
    );
  }

  // Build the navigation drawer for the admin panel
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
              child: Icon(Icons.admin_panel_settings, color: Colors.blue, size: 40),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Users'),
            onTap: () {
              // Navigate to Users page (add navigation here)
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Bills'),
            onTap: () {
              // Navigate to Bills page (add navigation here)
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Navigate to Settings page (add navigation here)
            },
          ),
        ],
      ),
    );
  }
}
