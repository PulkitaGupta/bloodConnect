import 'package:flutter/material.dart';

class ManageStockScreen extends StatefulWidget {
  @override
  _ManageStockScreenState createState() => _ManageStockScreenState();
}

class _ManageStockScreenState extends State<ManageStockScreen> {
  final List<Map<String, dynamic>> bloodStock = [
    {'type': 'A+', 'quantity': 50},
    {'type': 'B+', 'quantity': 45},
    {'type': 'AB+', 'quantity': 30},
    {'type': 'O+', 'quantity': 60},
    {'type': 'A-', 'quantity': 20},
    {'type': 'B-', 'quantity': 25},
    {'type': 'AB-', 'quantity': 15},
    {'type': 'O-', 'quantity': 40},
  ];

  void _updateStock(int index, int change) {
    setState(() {
      bloodStock[index]['quantity'] =
          (bloodStock[index]['quantity'] + change).clamp(0, 1000);
    });
  }

  void _saveChanges() {
    // Implement backend update logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Stock updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Stock')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Adjust for different screens
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85, // Reduced from 1.2 to avoid overflow
          ),
          itemCount: bloodStock.length,
          itemBuilder: (context, index) {
            return _buildBloodTypeCard(index);
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          onPressed: _saveChanges,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Update Stock'),
        ),
      ),
    );
  }

  Widget _buildBloodTypeCard(int index) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Text(
                bloodStock[index]['type'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                'Quantity: ${bloodStock[index]['quantity']}',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle, color: Colors.red, size: 30),
                  onPressed: () => _updateStock(index, -1),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle, color: Colors.green, size: 30),
                  onPressed: () => _updateStock(index, 1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
