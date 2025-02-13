import 'package:flutter/material.dart';

class FindDonorScreen extends StatefulWidget {
  @override
  _FindDonorScreenState createState() => _FindDonorScreenState();
}

class _FindDonorScreenState extends State<FindDonorScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Find Donor')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Blood type, Location',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Replace with actual search results
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text('Donor Name $index'),
                  subtitle: Text('Blood Type: A+, Location: City $index'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DonorProfileScreen(donorIndex: index),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DonorProfileScreen extends StatelessWidget {
  final int donorIndex;

  DonorProfileScreen({required this.donorIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Donor Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            SizedBox(height: 16),
            Text('Name: Donor Name $donorIndex',
                style: TextStyle(fontSize: 18)),
            Text('Blood Type: A+', style: TextStyle(fontSize: 18)),
            Text('Location: City $donorIndex', style: TextStyle(fontSize: 18)),
            Text('Contact: 123-456-7890', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
