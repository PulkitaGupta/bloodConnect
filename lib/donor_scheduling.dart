import 'package:flutter/material.dart';

class DonorSchedulingScreen extends StatefulWidget {
  @override
  _DonorSchedulingScreenState createState() => _DonorSchedulingScreenState();
}

class _DonorSchedulingScreenState extends State<DonorSchedulingScreen> {
  List<Event> _events = [];

  // Form field controllers
  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String _selectedBloodType = 'A+';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Donor Scheduling')),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventDialog,
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
          _buildTextField(_hospitalController, 'Hospital/Donor Name'),
          _buildTextField(_timeController, 'Time (e.g., 10:00 AM)'),
          _buildDropdownButton(),
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
            subtitle: Text('${event.time} - Blood Type: ${event.bloodType}'),
            trailing: IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _showEditEventDialog(index),
            ),
          ),
        );
      },
    );
  }

  void _addEvent() {
    String title = _hospitalController.text;
    String time = _timeController.text;

    if (title.isNotEmpty && time.isNotEmpty) {
      setState(() {
        _events.add(Event(title, time, _selectedBloodType));
      });

      // Clear form fields
      _hospitalController.clear();
      _timeController.clear();
      _selectedBloodType = 'A+';
    }
  }

  Future<void> _showAddEventDialog() async {
    TextEditingController hospitalController = TextEditingController();
    TextEditingController timeController = TextEditingController();
    String selectedBloodType = 'A+';

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('New Appointment'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(hospitalController, 'Hospital/Donor Name'),
                  _buildTextField(timeController, 'Time'),
                  DropdownButton<String>(
                    value: selectedBloodType,
                    onChanged: (newValue) {
                      setDialogState(() {
                        selectedBloodType = newValue!;
                      });
                    },
                    items: ['A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-']
                        .map((type) =>
                            DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (hospitalController.text.isNotEmpty &&
                        timeController.text.isNotEmpty) {
                      setState(() {
                        _events.add(Event(hospitalController.text,
                            timeController.text, selectedBloodType));
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showEditEventDialog(int index) async {
    final TextEditingController titleController =
        TextEditingController(text: _events[index].title);
    final TextEditingController timeController =
        TextEditingController(text: _events[index].time);
    String bloodType = _events[index].bloodType;

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Edit Appointment'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(titleController, 'Hospital/Donor Name'),
                  _buildTextField(timeController, 'Time'),
                  DropdownButton<String>(
                    value: bloodType,
                    onChanged: (newValue) {
                      setDialogState(() {
                        bloodType = newValue!;
                      });
                    },
                    items: ['A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-']
                        .map((type) =>
                            DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _events[index] = Event(
                          titleController.text, timeController.text, bloodType);
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
    );
  }

  Widget _buildDropdownButton() {
    return DropdownButton<String>(
      value: _selectedBloodType,
      onChanged: (newValue) {
        setState(() {
          _selectedBloodType = newValue!;
        });
      },
      items: ['A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-']
          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
          .toList(),
    );
  }
}

class Event {
  String title, time, bloodType;
  Event(this.title, this.time, this.bloodType);
}
