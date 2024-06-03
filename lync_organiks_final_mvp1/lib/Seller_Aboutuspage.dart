import 'package:flutter/material.dart';

class SellerAboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF082e1b),
        title: Center(
          child: Text(
            'About Us',
            style: TextStyle(color: Colors.white),
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigate back to the SellerHomePage
            Navigator.pop(context);
          },
        ),
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
      color: Colors.grey,
      height: 200,
      child: Image.asset(
        'images/e.jpg',
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
              color: Color(0xFF082e1b),
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
              color: Color(0xFF082e1b),
              fontSize: 24,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 250,
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
      padding: EdgeInsets.symmetric(horizontal: 8),
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
