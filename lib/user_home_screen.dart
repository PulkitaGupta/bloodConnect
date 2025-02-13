import 'package:flutter/material.dart';

class UserHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Dashboard')),
      body: ListView(
        children: <Widget>[
          // Example Past Donation Record
          _buildDonationHistoryCard(context,
              date: 'Jan 10, 2025', bloodType: 'B+', hospital: 'City Hospital'),

          // Buttons for User Actions
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/findDonor'),
                  child: Text('Find Donor'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/requestBlood'),
                  child: Text('Request Blood'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/donationHistory'),
                  child: Text('Donation History'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonationHistoryCard(BuildContext context,
      {required String date,
      required String bloodType,
      required String hospital}) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(Icons.history)),
        title: Text('Last Donation: $date'),
        subtitle: Text('Blood Type: $bloodType\nHospital: $hospital'),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to full donation history page
        },
      ),
    );
  }
}
