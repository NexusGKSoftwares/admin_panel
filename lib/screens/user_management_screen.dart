import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({Key? key}) : super(key: key);

  @override
  _UserManagementScreenState createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  List<Map<String, String>> users = [];  // List to hold user data

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String? _selectedUserId;

  // Fetch users from the server
  Future<void> _fetchUsers() async {
    final response = await http.get(Uri.parse('http://localhost/pure/get_users.php'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      if (data['success'] == true) {
        List<dynamic> usersData = data['users'];

        setState(() {
          users = usersData.map<Map<String, String>>((user) {
            return {
              'id': user['id'].toString(),
              'name': user['name']?.toString() ?? 'No Name',
              'email': user['email']?.toString() ?? 'No Email',
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to load users');
      }
    } else {
      throw Exception('Failed to load users');
    }
  }

  // Add or edit a user (currently just updates locally for now)
  void _addOrEditUser() {
    final String name = _nameController.text;
    final String email = _emailController.text;
    
    if (_selectedUserId != null) {
      // Edit existing user
      setState(() {
        final userIndex = users.indexWhere((user) => user['id'] == _selectedUserId);
        users[userIndex] = {
          "id": _selectedUserId!,
          "name": name,
          "email": email,
        };
      });
    } else {
      // Add new user (locally, ideally, you should call an API to add the user to the backend)
      setState(() {
        users.add({
          "id": DateTime.now().millisecondsSinceEpoch.toString(),
          "name": name,
          "email": email,
        });
      });
    }
    _resetForm();
  }

  // Reset the form fields
  void _resetForm() {
    _nameController.clear();
    _emailController.clear();
    _selectedUserId = null;
  }

  // Edit an existing user's details
  void _editUser(Map<String, String> user) {
    setState(() {
      _nameController.text = user["name"]!;
      _emailController.text = user["email"]!;
      _selectedUserId = user["id"];
    });
  }

  // Delete a user (for now, deletes only locally)
  void _deleteUser(String userId) {
    setState(() {
      users.removeWhere((user) => user["id"] == userId);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers();  // Fetch users when the screen is loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Management"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Form for Add/Edit
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _addOrEditUser,
                  child: Text(_selectedUserId == null ? "Add User" : "Update User"),
                ),
                if (_selectedUserId != null)
                  TextButton(
                    onPressed: _resetForm,
                    child: const Text("Cancel"),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            // User List
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(user["name"]!),
                      subtitle: Text(user["email"]!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editUser(user),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteUser(user["id"]!),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
