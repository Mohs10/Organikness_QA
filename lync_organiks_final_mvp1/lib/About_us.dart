import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: AboutPage(),
  ));
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF082e1b), // Change app bar color
        title: Center(
          child: Text('About Us', style: TextStyle(color: Colors.white)), // Change text color
        ),
        automaticallyImplyLeading: false, // Remove back arrow icon
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageSection(),
            DescriptionSection(),
            ClientsSection(),
          ],
        ),
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey, // Placeholder color
      height: 200,
      child: Image.asset(
        'images/e.jpg', // Replace with your local image path
        fit: BoxFit.cover,
      ),
    );
  }
}

class DescriptionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Our App',
            style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Color(0xFF082e1b), // Change text color
              fontSize: 24,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
                'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in '
                'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
            style: Theme.of(context).textTheme.headline6!.copyWith(
              // color: Color(0xFF082e1b), // Change text color
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class ClientsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Clients',
            style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Color(0xFF082e1b), // Change text color
              fontSize: 24,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 250, // Adjust the height as needed
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ClientTile(
                  imagePath: 'images/user_icon.png',
                  imageName: 'Client 1',
                  fontSize: 16,
                  fontColor: Colors.black,
                ),
                ClientTile(
                  imagePath: 'images/user_icon.png',
                  imageName: 'Client 2',
                  fontSize: 16,
                  fontColor: Colors.black,
                ),
                ClientTile(
                  imagePath: 'images/user_icon.png',
                  imageName: 'Client 3',
                  fontSize: 16,
                  fontColor: Colors.black,
                ),
                ClientTile(
                  imagePath: 'images/user_icon.png',
                  imageName: 'Client 4',
                  fontSize: 16,
                  fontColor: Colors.black,
                ),
                // Add more ClientTile widgets as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClientTile extends StatelessWidget {
  final String imagePath;
  final String imageName;
  final double fontSize;
  final Color fontColor;

  ClientTile({
    required this.imagePath,
    required this.imageName,
    required this.fontSize,
    required this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8), // Add padding for spacing
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(height: 8),
          Text(
            imageName,
            style: TextStyle(fontSize: fontSize, color: fontColor),
          ),
        ],
      ),
    );
  }
}
