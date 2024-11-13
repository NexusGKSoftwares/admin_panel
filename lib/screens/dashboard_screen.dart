import 'package:flutter/material.dart';

// Import your existing pages here
import 'billing_management_screen.dart';
import 'meter_reading_screen.dart';
import 'notifications_screen.dart';
import 'payments_screen.dart';
import 'reports_screen.dart';
import 'user_management_screen.dart';

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
              _buildRecentActivitySection(context),
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
            _buildCard('Active ', '280', Colors.teal),
            _buildCard('Total Bills', '1000', Colors.orangeAccent),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCard('Unpaid Bills', '500', Colors.redAccent),
            _buildCard('Payments', '1500', Colors.purpleAccent),
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
  Widget _buildRecentActivitySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        _buildRecentActivityItem('New User Registered', 'John Doe', context),
        _buildRecentActivityItem('Bill Generated', 'User123', context),
        _buildRecentActivityItem('Payment Received', 'User456', context),
        _buildRecentActivityItem('Meter Reading Added', 'User789', context),
      ],
    );
  }

  // Recent activity item
  Widget _buildRecentActivityItem(String action, String user, BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.notification_important, color: Colors.blueAccent),
      title: Text(action, style: const TextStyle(color: Colors.black87)),
      subtitle: Text('User: $user', style: TextStyle(color: Colors.grey[600])),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
      onTap: () {
        if (action == 'New User Registered') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserManagementScreen()),
          );
        } else if (action == 'Bill Generated') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BillingManagementScreen()),
          );
        } else if (action == 'Payment Received') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentsScreen()),
          );
        } else if (action == 'Meter Reading Added') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MeterReadingScreen()),
          );
        }
      },
    );
  }

  // Drawer
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserManagementScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment, color: Colors.blueAccent),
            title: const Text('Bills', style: TextStyle(color: Colors.black87)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BillingManagementScreen()),
              );
            },
          ),
            ListTile(
            leading: const Icon(Icons.payment, color: Colors.blueAccent),
            title: const Text('Meter Reading', style: TextStyle(color: Colors.black87)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MeterReadingScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications, color: Colors.blueAccent),
            title: const Text('Notifications', style: TextStyle(color: Colors.black87)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.monetization_on, color: Colors.blueAccent),
            title: const Text('Payments', style: TextStyle(color: Colors.black87)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.report, color: Colors.blueAccent),
            title: const Text('Reports', style: TextStyle(color: Colors.black87)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReportsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.blueAccent),
            title: const Text('Settings', style: TextStyle(color: Colors.black87)),
            onTap: () {
              // You can add navigation for Settings if needed
            },
          ),
        ],
      ),
    );
  }
}
