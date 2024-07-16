import 'package:flutter/material.dart';
import 'package:new_project1/seller_registration_page.dart';

class WelcomeSellerPage extends StatefulWidget {
  final String uid;

  WelcomeSellerPage({required this.uid});

  @override
  State<WelcomeSellerPage> createState() => _WelcomeSellerPageState();
}

class _WelcomeSellerPageState extends State<WelcomeSellerPage> {

  @override
  Widget build(BuildContext context) {
    String uid = widget.uid.toString();
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "You are not a",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Text(
                "Registered Seller!",
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF84C86D), // Set your desired text color here
                ),
              ),
              SizedBox(height: 20),

              Image.asset(
                'images/welcome.gif',
                width: 300,
                height: 300,
              ),
              SizedBox(height: 20),

              Text(
                "To register yourself as a seller, click on the button below.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),

              Container(
                width: 340,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SellerRegistationPage(uid: uid)), // Replace 'DestinationPage' with your actual destination page class
    );
    },// Handle button click (navigate to registration page or perform registration logic)

                  child: Text(
                    "Register as Seller",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF84C86D),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
