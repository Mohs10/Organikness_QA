import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  final List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      imagePath: 'images/Woman.jpg', // Replace with your image path
      line1: 'Welcome to MyApp',
      line2: 'Discover amazing features',
    ),
    OnboardingItem(
      imagePath: 'images/e.jpg', // Replace with your image path
      line1: 'Stay connected',
      line2: 'Keep up with the latest updates',
    ),
    OnboardingItem(
      imagePath: 'images/e.jpg', // Replace with your image path
      line1: 'Get started',
      line2: 'Explore and enjoy our app',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        onboardingItems[0].imagePath,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 16.0,
                  left: 16.0,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Handle skip button press
                        // You can navigate to the main screen or perform other actions
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.0),
                Text(
                  onboardingItems[0].line1,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  onboardingItems[0].line2,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Handle next button press
              // You can navigate to the main screen or perform other actions
            },
            child: Text(
              'Next',
              style: TextStyle(fontSize: 18.0),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0), // Adjust the button size as needed
              primary: Colors.green, // Change the color of the button
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final String imagePath;
  final String line1;
  final String line2;

  OnboardingItem({
    required this.imagePath,
    required this.line1,
    required this.line2,
  });
}
