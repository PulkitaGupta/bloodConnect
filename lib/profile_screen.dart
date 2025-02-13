import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "ABC Blood Bank";
  String location = "New Delhi, India";
  String contact = "+91 9876543210";
  String email = "contact@abcbloodbank.com";
  String services = "Blood Donation, Emergency Supply, Plasma Therapy";

  void _editProfile() {
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController locationController =
        TextEditingController(text: location);
    TextEditingController contactController =
        TextEditingController(text: contact);
    TextEditingController emailController = TextEditingController(text: email);
    TextEditingController servicesController =
        TextEditingController(text: services);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Profile"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField("Name", nameController),
                _buildTextField("Location", locationController),
                _buildTextField("Contact", contactController),
                _buildTextField("Email", emailController),
                _buildTextField("Services", servicesController),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            TextButton(
              onPressed: () {
                setState(() {
                  name = nameController.text;
                  location = locationController.text;
                  contact = contactController.text;
                  email = emailController.text;
                  services = servicesController.text;
                });
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.red[100],
                child: Icon(Icons.local_hospital, size: 60, color: Colors.red),
              ),
              SizedBox(height: 12),
              Text(name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(location,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              SizedBox(height: 20),
              _buildProfileDetail(Icons.phone, "Contact", contact),
              _buildProfileDetail(Icons.email, "Email", email),
              _buildProfileDetail(Icons.local_hospital, "Services", services),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _editProfile,
                icon: Icon(Icons.edit),
                label: Text("Edit Profile"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetail(IconData icon, String title, String value) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.red),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}
