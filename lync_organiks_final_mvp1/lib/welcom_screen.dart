import 'package:flutter/material.dart';
import 'package:new_project1/login_choose.dart';
import 'package:new_project1/register_choose.dart';
import 'package:new_project1/signup_page.dart';
import 'Log_in.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.asset(
              'images/welcome.gif', // Replace with your image path
              fit: BoxFit.contain,
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
    text: "Discover the ",
    style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.black,
      // Color for the text before "perfect platform"
    ),
    ),
    TextSpan(
    text: "perfect platform",
    style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Color(0xFF84C86D), // Color for "perfect platform"
    ),
    ),
    TextSpan(
    text: " for your space!",
    style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.black, // Color for the text after "perfect platform"
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
                  "Get access to a wide variety of Catagories of crops with just a few steps.",
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
    MaterialPageRoute(builder: (context) => RegisterChooseScreen()), // Replace 'DestinationPage' with your actual destination page class
    );
    },

                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF84C86D), // Set the background color to #84C86D
                    ),
                    child: Text("Let's Get Started"),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Add your action here
                //   },
                //   child: Text("Get Started"),
                //
                // ),
                SizedBox(height: 10),


                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginChooseScreen(), // Replace 'DestinationPage' with your actual destination page class
                        )
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      // style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                    TextSpan(
                    text: "Already have an account? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,// Color for the text before "Sign in"
                      ),
                    ),

    TextSpan(
    text: "Sign in",
    style: TextStyle(
    color: Color(0xFF84C86D),
      height: 1,
      fontSize: 15.0// Color for "Sign in"
    ),
    ),
    ],
    ),
    ),
    ),
    ]
    ),
                ),
              ]
    )
    );
  }
}

