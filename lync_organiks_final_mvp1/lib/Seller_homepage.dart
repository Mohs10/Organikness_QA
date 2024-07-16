import 'package:flutter/material.dart';
import 'package:new_project1/Account_profile.dart';
import 'package:new_project1/Market_place.dart';
import 'package:new_project1/Notifications_page.dart';
import 'package:new_project1/Order_page.dart';
import 'package:new_project1/Seller_Aboutuspage.dart';
import 'package:new_project1/Seller_OrderPage.dart';

import 'package:new_project1/Seller_ProductPage.dart';
import 'package:new_project1/Seller_Profilepage.dart';
import 'package:new_project1/Seller_RequestPage.dart';
import 'package:new_project1/welcom_screen.dart';

import 'Buyer_homepage.dart';
import 'Seller_Transactionfile.dart';

class SellerHomePage extends StatefulWidget {
  @override
  State<SellerHomePage> createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  int _currentIndex = 0;

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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF082e1b),
          title: Text("Seller Portal"),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _showLogoutConfirmationDialog();
              },
            ),
          ],
          centerTitle: true,
        ),
        body: HomeContent(),

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: Color(0xFF082e1b),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });

            switch (index) {
              case 0:
              // Navigate to the home page
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => Marketplace(),
              // ));
                break;
              case 1:
              // Navigate to the about us page
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SellerAboutPage(),
                ));
                break;
              case 2:
              // Navigate to the profile page
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SellerProfilePage(),
                ));
                break;
              case 3:
              // Navigate to the seller page
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => SellerHomePage(),
              // ));
                break;
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: "About Us",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.store),
            //   label: "Seller",
            // ),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              // Navigate to profile or other page
            },
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.2,
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
                          height: MediaQuery
                              .of(context)
                              .size
                              .width * 0.18,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          "Hi",
                          style: TextStyle(
                            fontSize: MediaQuery
                                .of(context)
                                .size
                                .width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Welcome to LYNC",
                          style: TextStyle(
                            fontSize: MediaQuery
                                .of(context)
                                .size
                                .width * 0.035,
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
          Row(
            children: [
              buildDashboardItem(
                icon: Icons.shopping_bag,
                title: "Total Products",
                value: "0",
                boxWidth: MediaQuery
                    .of(context)
                    .size
                    .width * 0.3,
                boxHeight: 120.0,
                gradientColors: [Color(0xFF84C86D), Color(0xFF9EDB97)],
              ),
              buildDashboardItem(
                icon: Icons.monetization_on,
                title: "Transactions",
                value: "\$0",
                boxWidth: MediaQuery
                    .of(context)
                    .size
                    .width * 0.3,
                boxHeight: 120.0,
                gradientColors: [Color(0xFFFFB84C), Color(0xFFFFD57C)],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              buildDashboardItem(
                icon: Icons.email,
                title: "Requests",
                value: "0",
                boxWidth: MediaQuery
                    .of(context)
                    .size
                    .width * 0.3,
                boxHeight: 120.0,
                gradientColors: [Color(0xFF4E89FC), Color(0xFF7FAEFB)],
              ),
              buildDashboardItem(
                icon: Icons.assignment,
                title: "Orders",
                value: "0",
                boxWidth: MediaQuery
                    .of(context)
                    .size
                    .width * 0.3,
                boxHeight: 120.0,
                gradientColors: [Color(0xFFFA6E5A), Color(0xFFF68D7F)],
              ),
            ],
          ),
          SizedBox(height: 0),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Seller Tools",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildFlexBox(
                "Add Products",
                Icons.shopping_bag,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SellerProductPage(),
                    ),
                  );
                },
              ),
              buildFlexBox(
                "View Requests",
                Icons.email,
                onTap: () {
                  Navigator.push(
                    context,
                  MaterialPageRoute(
                  builder: (context) => SellerRequestPage(),
                    ),
                  );
                },
              ),
              buildFlexBox(
                "View Orders",
                Icons.assignment,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SellerOrderPage(),
                    ),
                  );
                },
              ),
              buildFlexBox(
                "Transactions",
                Icons.monetization_on,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionPage(),
                    ),
                  ); // Handle click on Transactions
                  // Add navigation logic or perform actions here
                },
              ),
            ],
          ),
          SizedBox(height: 30,),
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
    );
  }

  Widget buildFlexBox(String title, IconData icon, {void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.greenAccent.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Color(0xFF082e1b),
              size: 30,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDashboardItem({
    required IconData icon,
    required String title,
    required String value,
    required double boxWidth,
    required double boxHeight,
    required List<Color> gradientColors,
  }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0, bottom: 0.0),
        width: boxWidth,
        height: boxHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
          ),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}



