import 'package:flutter/material.dart';
import 'package:new_project1/signup_page.dart';
import 'Log_in.dart';

class RegisterChooseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: ListView(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Image.asset(
                  'images/register1.jpg', // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          // style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: "How would you like to ",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                // Color for the text before "perfect platform"
                              ),
                            ),
                            TextSpan(
                              text: "Register?",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF84C86D), // Color for "perfect platform"
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),

                      // textAlign: TextAlign.center,
                      //             ),
                      SizedBox(height: 20),
                      Text(
                        "Please choose the appropriate role below.",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 10),
                      Container(
                        height: 50, // Set the desired height
                        width: 300,  // Set the desired width
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignupPage(role: 'Buyer',)), // Replace 'DestinationPage' with your actual destination page class
                            );
                          },

                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF84C86D), // Set the background color to #84C86D
                          ),
                          child: Text("Register As A Buyer"),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 50,
                        width: 300,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupPage(role: 'Seller',)),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            primary: Colors.white, // Fill color
                            side: BorderSide(
                            color: Color(0xFF84C86D), // Border color
                            width: 2.0, // Thickness of the border
                            ),
                          ),
                          child: Text(
                          "Register As A Seller",
                          style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     // Add your action here
                      //   },
                      //   child: Text("Get Started"),
                      //
                      // ),
                    ]
                ),
              ),
            ]
        )
    );
  }
}

