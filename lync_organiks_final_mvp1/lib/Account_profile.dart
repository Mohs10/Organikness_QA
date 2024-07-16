import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:new_project1/Buyer_homepage.dart';
import 'Log_in.dart';

class AccountPage extends StatefulWidget {
  final String username;
  final String address;
  final String mobilenumber;
  final String uid;

  AccountPage({required this.username, required this.address, required this.mobilenumber, required this.uid});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String profileImagePath = ''; // Initial image path

  Future<bool> _onWillPop() async {
    // Prevent going back to the homepage by overriding the system back button
    return false;
  }

  void _editProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController nameController = TextEditingController();
        TextEditingController phoneController = TextEditingController();
        TextEditingController addressController = TextEditingController();

        return AlertDialog(
          title: Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Name Input
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  focusedBorder: UnderlineInputBorder(),
                ),
              ),
              // Phone Number Input
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  focusedBorder: UnderlineInputBorder(),
                ),
              ),
              // Address Input
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  focusedBorder: UnderlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Color(0xFF84C86D)),
              ),
            ),
            TextButton(
              onPressed: () {
                String updatedName = nameController.text;
                String updatedPhone = phoneController.text;
                String updatedAddress = addressController.text;

                // Update the profile information or take any necessary action
                // You can update the information in your app's state or database here

                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Save', style: TextStyle(color: Color(0xFF84C86D)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _changeProfileImage(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        profileImagePath = file.path!;
      });
    }
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Do you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            // TextButton(
            //   onPressed: () {
            //     // Implement logout functionality here, e.g., clear user session
            //     Navigator.of(context).pop();
            //     // Navigate to the "Login" page and prevent the user from going back
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => LoginPage(),
            //       ),
            //     );
            //   },
            //   child: Text('Yes'),
            // ),
          ],
        );
      },
    );
  }

  // Simulate clearing user session (replace with your actual session management code)
  void clearUserSession() {
    // Replace this with your actual session management code to clear tokens,
    // reset user data, or any other necessary actions for a complete logout.
  }

  @override
  Widget build(BuildContext context) {
    String username = widget.username;
    String address = widget.address;
    String mobilenumber = widget.mobilenumber;
    String uid = widget.uid;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF84C86D),
          title: Center(child: Text("Profile")),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BuyerHomePage(username: username, address: address, mobilenumber: mobilenumber,uid:uid),
                ),
              );
            },
          ),
        ),
        body: WillPopScope(
          onWillPop: _onWillPop,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  elevation: 5.0,
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(profileImagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Image.asset(
                            'images/user_icon.png',
                            width: 45,
                            height: 45,
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${username}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Color(0xFF84C86D),
                                    size: 20.0,
                                  ),
                                  SizedBox(width: 10.0),
                                  Text('${mobilenumber}'),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.place,
                                    color: Color(0xFF84C86D),
                                    size: 20.0,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text('${address}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // _editProfile(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16.0),
                Card(
                  elevation: 5.0,
                  shadowColor: Colors.grey,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.shopping_cart),
                        title: Text('My Cart'),
                        onTap: () {
                          // Implement My Cart functionality here
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Settings'),
                        onTap: () {
                          // Implement Settings functionality here
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.feedback),
                        title: Text('Feedback'),
                        onTap: () {
                          // Implement Feedback functionality here
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Logout'),
                        onTap: () {
                          _logout(context);
                        },
                      ),
                    ],
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
