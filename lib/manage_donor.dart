import 'package:flutter/material.dart';

class ManageDonorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Donors')),
      body: ListView.builder(
        itemCount: 10, // Replace with actual donor count
        itemBuilder: (context, index) {
          return _buildDonorListTile(context, index);
        },
      ),
    );
  }

  Widget _buildDonorListTile(BuildContext context, int index) {
    // Replace with actual donor data from your backend.
    String name = 'Donor ${index + 1}';
    String bloodType = 'A+';
    String timeToReach =
        '${(10 + index * 5)} mins'; // Example: 10, 15, 20 mins...

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(child: Icon(Icons.person)),
        title: Text(name),
        subtitle: Text('Blood Type: $bloodType'),
        onTap: () {
          // Navigate to Donor Profile Screen when tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DonorProfileScreen(
                name: name,
                bloodType: bloodType,
                timeToReach: timeToReach,
              ),
            ),
          );
        },
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.check_circle, color: Colors.green),
              onPressed: () {
                // Handle approve action
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('$name approved!')));
              },
            ),
            IconButton(
              icon: Icon(Icons.cancel, color: Colors.red),
              onPressed: () {
                // Handle decline action
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('$name declined!')));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DonorProfileScreen extends StatelessWidget {
  final String name;
  final String bloodType;
  final String timeToReach;

  DonorProfileScreen(
      {required this.name, required this.bloodType, required this.timeToReach});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$name\'s Profile')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
            ),
            SizedBox(height: 20),
            Text('Name: $name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Blood Type: $bloodType', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Contact: +91 9876543210',
                style: TextStyle(fontSize: 16)), // Replace with real data
            SizedBox(height: 10),
            Text('Location: Delhi, India',
                style: TextStyle(fontSize: 16)), // Replace with real data
            SizedBox(height: 10),
            Text('Time to Reach: $timeToReach',
                style: TextStyle(fontSize: 16, color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
