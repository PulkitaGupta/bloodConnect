import 'package:flutter/material.dart';

class HospitalHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hospital Dashboard')),
      body: ListView(
        children: <Widget>[
          // Example Blood Request Status
          _buildRequestStatusCard(context,
              requestId: 'REQ123', status: 'Pending', bloodType: 'O+'),

          // Buttons for Hospital Actions
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/requestBlood'),
                  child: Text('Request Blood'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/viewStock'),
                  child: Text('View Blood Stock'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/trackRequests'),
                  child: Text('Track Requests'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestStatusCard(BuildContext context,
      {required String requestId,
      required String status,
      required String bloodType}) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(Icons.local_hospital)),
        title: Text('Request ID: $requestId'),
        subtitle: Text('Blood Type: $bloodType\nStatus: $status'),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to detailed request tracking page
        },
      ),
    );
  }
}
