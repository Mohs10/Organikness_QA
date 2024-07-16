import 'package:flutter/material.dart';
import 'package:new_project1/About_us.dart';
import 'package:new_project1/Account_profile.dart';
import 'package:new_project1/Buyer_order_page.dart';
import 'package:new_project1/New_onboarding_screens.dart';
import 'package:new_project1/Product_details.dart';
import 'package:new_project1/Profile_page.dart';
import 'package:new_project1/buyer_product_list_page.dart';
import 'package:new_project1/welcom_screen.dart';

import 'Querypage.dart';

class BuyerHomePage extends StatefulWidget {
  final String username;
  final String address;
  final String mobilenumber;
  final String uid;

  BuyerHomePage({
    required this.username,
    required this.address,
    required this.mobilenumber,
    required this.uid,
  });

  @override
  _BuyerHomePageState createState() => _BuyerHomePageState();
}

class _BuyerHomePageState extends State<BuyerHomePage> {
  final PageController _pageController = PageController();
  late Future<void> _logoutFuture;

  // Method to show logout confirmation dialog
  Future<void> _showLogoutConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout Confirmation'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Implement logout logic here
                // For example:
                _logoutFuture = Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String username = widget.username;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF082e1b),
          elevation: 2,
          title: Text("Buyer Portal", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          actions: [
            // Logout icon
            IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                _showLogoutConfirmationDialog();
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    // Navigate to profile or other page
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/w1.jpg'),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(1),
                          BlendMode.dstATop,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/user_icon.png',
                                height: MediaQuery.of(context).size.width * 0.18,
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                "Hi $username",
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Welcome to LYNC",
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.035,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 0),


                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color(0xFFfaf5f1),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: buildClickableOption('images/product1.jpg', "Product", () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ProductPage()),
                                );
                              }),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                            Expanded(
                              child: buildClickableOption('images/query1.jpg', "Queries", () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => QueryPage()),
                                );
                              }),
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: buildClickableOption('images/order1.jpg', "Order", () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => BuyerOrderPage()),
                                );// Add navigation to OrderPage
                              }),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                            Expanded(
                              child: buildClickableOption('images/payment1.jpg', "Payment", () {
                                // Add navigation to PaymentPage
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Handle click on the button
                      // Add navigation logic or perform actions here
                    },
                    icon: Icon(Icons.message),
                    label: Text("Do you need any assistance?"),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF082e1b), // Button color
                      onPrimary: Colors.white, // Text color
                      minimumSize: Size(340, 50), // Button width and height
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          selectedItemColor: Color(0xFF082e1b),
          onTap: (index) {
            if (index == 0) {
              // Handle Home Click
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );// Handle About Click
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              ); //  // Handle Profile Click
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: "About",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  Widget buildClickableOption(String imagePath, String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),

            // Translucent container with title
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      Colors.black54,
                      Colors.black.withOpacity(0.2),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBannerItem(String imagePath) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Widget for each dot in the PageView
  Widget buildDot(int index, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 12.0,
      width: 12.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.green : Colors.grey,
        border: Border.all(
          color: isSelected ? Colors.white : Colors.green,
          width: 2.0,
        ),
      ),
    );
  }

  // Method to create dots based on the number of banner items
  Widget buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3, // Change this to the number of banner items
            (index) => buildDot(index, index == _pageController.page?.round()),
      ),
    );
  }

  // Dispose the PageController when the widget is disposed
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
