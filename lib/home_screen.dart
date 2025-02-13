import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Tracks the currently selected index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BloodConnect'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Image
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Raktdaan.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Manage Blood Donations Efficiently!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            // Grid of Features
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
                children: [
                  _buildFeatureCard(
                      context, 'Manage Donor', Icons.people, '/manageDonor'),
                  _buildFeatureCard(context, 'Request Blood', Icons.bloodtype,
                      '/requestBlood'),
                  _buildFeatureCard(
                      context, 'Manage Stock', Icons.storage, '/manageStock'),
                  _buildFeatureCard(context, 'Donor Scheduling',
                      Icons.calendar_today, '/donorScheduling'),
                ],
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Change selected screen
          });

          // Navigate to respective screens based on index
          if (_currentIndex == 0) {
            Navigator.pushNamed(context, '/');
          } else if (_currentIndex == 1) {
            Navigator.pushNamed(context, '/findDonor');
          } else if (_currentIndex == 2) {
            Navigator.pushNamed(context, '/profile');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Find Donor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, String title, IconData icon, String route) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route); // Navigate via named routes
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.red),
            SizedBox(height: 10),
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
