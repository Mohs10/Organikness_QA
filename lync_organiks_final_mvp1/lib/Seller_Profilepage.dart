import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
 // Import SellerHomePage if not already imported

class SellerProfilePage extends StatelessWidget {
  // Profile information
  final String name = 'John Doe';
  final String phoneNumber = '123-456-7890';
  final String address = 'New York, USA';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF082e1b),
          title: Text("Edit Profile"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigate back to SellerHomePage when the back arrow is clicked
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () {
                    // Call the function to pick an image
                    // _pickImage();
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

                SizedBox(height: 20.0),

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

                SizedBox(height: 60.0),

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

void main() {
  runApp(MaterialApp(
    home: SellerProfilePage(),
  ));
}
