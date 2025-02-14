import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DonorSchedulingScreen extends StatefulWidget {
  @override
  _DonorSchedulingScreenState createState() => _DonorSchedulingScreenState();
}

class _DonorSchedulingScreenState extends State<DonorSchedulingScreen> {
  List<Event> _events = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _selectedBloodType = 'A+';
  String? _selectedDate;
  String? _selectedLocation;
  String? _selectedTime;

  List<String> availableDates = [
    '10 Feb 2025',
    '15 Feb 2025',
    '20 Feb 2025'
  ]; // Replace with drive data
  List<String> locations = ['Hospital A', 'Hospital B', 'Community Center'];
  List<String> availableTimes = [
    '08:00 AM',
    '10:00 AM',
    '12:00 PM',
    '02:00 PM',
    '04:00 PM'
  ]; // Predefined times

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Donor Scheduling')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEventDialog(context),
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          _buildAppointmentForm(),
          Expanded(child: _buildScheduledAppointmentsList()),
        ],
      ),
    );
  }

  Widget _buildAppointmentForm() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Schedule a New Appointment',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          _buildTextField(_nameController, 'Donor Name'),
          _buildDropdownButton('Select Time', _selectedTime, availableTimes,
              (newValue) {
            setState(() {
              _selectedTime = newValue;
            });
          }),
          _buildDropdownButton('Blood Type', _selectedBloodType,
              ['A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-'], (newValue) {
            setState(() {
              _selectedBloodType = newValue!;
            });
          }),
          _buildDropdownButton('Select Date', _selectedDate, availableDates,
              (newValue) {
            setState(() {
              _selectedDate = newValue;
            });
          }),
          _buildDropdownButton('Select Location', _selectedLocation, locations,
              (newValue) {
            setState(() {
              _selectedLocation = newValue;
            });
          }),
          _buildTextField(_contactController, 'Contact Number'),
          _buildTextField(_ageController, 'Age'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _addEvent,
            child: Text('Schedule Appointment'),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduledAppointmentsList() {
    return ListView.builder(
      itemCount: _events.length,
      itemBuilder: (context, index) {
        final event = _events[index];
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: Icon(Icons.bloodtype, color: Colors.red),
            title: Text(event.title,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
                '${event.time} - ${event.bloodType}\nDate: ${event.date}\nLocation: ${event.location}\nContact: ${event.contact}\nAge: ${event.age}'),
          ),
        );
      },
    );
  }

  void _addEvent() {
    if (_nameController.text.isNotEmpty &&
        _selectedTime != null &&
        _selectedDate != null &&
        _selectedLocation != null) {
      setState(() {
        _events.add(Event(
          _nameController.text,
          _selectedTime!,
          _selectedBloodType,
          _selectedDate!,
          _selectedLocation!,
          _contactController.text,
          _ageController.text,
        ));
      });

      _nameController.clear();
      _contactController.clear();
      _ageController.clear();
      _selectedBloodType = 'A+';
      _selectedTime = null;
      _selectedDate = null;
      _selectedLocation = null;
    }
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
    );
  }

  Widget _buildDropdownButton(String label, String? selectedValue,
      List<String> items, ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      hint: Text(label),
      value: selectedValue,
      onChanged: onChanged,
      items: items
          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
          .toList(),
    );
  }

  // Method to show the dialog for adding an event
  void _showAddEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(_nameController, 'Donor Name'),
              _buildDropdownButton('Select Time', _selectedTime, availableTimes,
                  (newValue) {
                setState(() {
                  _selectedTime = newValue;
                });
              }),
              _buildDropdownButton('Blood Type', _selectedBloodType, [
                'A+',
                'B+',
                'AB+',
                'O+',
                'A-',
                'B-',
                'AB-',
                'O-'
              ], (newValue) {
                setState(() {
                  _selectedBloodType = newValue!;
                });
              }),
              _buildDropdownButton('Select Date', _selectedDate, availableDates,
                  (newValue) {
                setState(() {
                  _selectedDate = newValue;
                });
              }),
              _buildDropdownButton(
                  'Select Location', _selectedLocation, locations, (newValue) {
                setState(() {
                  _selectedLocation = newValue;
                });
              }),
              _buildTextField(_contactController, 'Contact Number'),
              _buildTextField(_ageController, 'Age'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addEvent();
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class Event {
  String title, time, bloodType, date, location, contact, age;
  Event(this.title, this.time, this.bloodType, this.date, this.location,
      this.contact, this.age);
}
