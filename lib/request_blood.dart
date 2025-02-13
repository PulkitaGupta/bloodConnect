import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RequestBloodScreen extends StatefulWidget {
  const RequestBloodScreen({Key? key}) : super(key: key);

  @override
  State<RequestBloodScreen> createState() => _RequestBloodScreenState();
}

class _RequestBloodScreenState extends State<RequestBloodScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedBloodType;
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();
  XFile? _prescriptionImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _prescriptionImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _urlController,
          decoration: const InputDecoration(
            hintText: "Enter URL",
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.url,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Blood Type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                value: _selectedBloodType,
                items: const ['A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-']
                    .map((bloodType) {
                  return DropdownMenuItem(
                    value: bloodType,
                    child: Text(bloodType),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedBloodType = newValue;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a blood type' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Enter Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter an address'
                    : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _hospitalController,
                decoration: InputDecoration(
                  labelText: 'Hospital Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a hospital name'
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text(_prescriptionImage == null
                    ? 'Upload Prescription'
                    : 'Change Prescription'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Blood Request Submitted!')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
