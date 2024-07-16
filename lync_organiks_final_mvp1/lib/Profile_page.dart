import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(ProfilePage());
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Profile information
  final String name = 'John Doe';
  final String phoneNumber = '123-456-7890';
  final String address = 'New York, USA';

  // Image Picker
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _imageFile; // Initialize to null

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final XFile? pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF082e1b),
          title: Text("Edit Profile"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image Holder with "+"
                InkWell(
                  onTap: () {
                    // Call the function to pick an image
                    _pickImage();
                  },
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        size: 40.0,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Change Image",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),

                SizedBox(height: 20.0), // Add space below image holder

                // Editable TextFields
                TextField(
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Address'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'User Identity'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Certificates'),
                ),

                SizedBox(height: 60.0), // Add space below text fields

                // Save Button
                ElevatedButton(
                  onPressed: () {
                    // Save the edited information
                    // Implement the logic to handle edited information
                  },
                  child: Text("Save"),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF082e1b),
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
