import 'package:flutter/material.dart';

class Marketpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF84C86D),
          title: Text("Marketplace"),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Handle menu icon tap action here
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Handle notification bell icon tap action here
              },
            ),
          ],
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(Icons.search, color: Color(0xFF84C86D)),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search',
                                suffixIcon: Icon(Icons.sort, color: Color(0xFF84C86D)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Product Containers
            buildProductContainer(
              'images/Maize_pro.png', // Replace with your image path
              'Product Name',
              'Per Kg Price: \$10.00',
              'Remaining Qty: 500MT',
              context,
            ),
            SizedBox(height: 16.0),
            // Add more product containers as needed
            buildProductContainer(
              'images/Grains2.png', // Replace with your image path
              'Product Name',
              'Per Kg Price: \$10.00',
              'Remaining Qty: 500MT',
              context,
            ),
          ],
        ),
      ),
    );
  }

  void navigateToProductPage(BuildContext context) {
    // Handle navigation to other pages here
  }

  Widget buildProductContainer(
      String imagePath, String productName, String price, String remainingQty, BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToProductPage(context); // Navigate to the product page when tapped
      },
      child: Container(

        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: const Offset(
                0.0,
                0.0,
              ),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            // Left column for image
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16.0),
            // Middle column for product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    price,
                    style: TextStyle(fontSize: 14.0),
                  ),
                  Text(
                    remainingQty,
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.0),
            // Right column for "View" button/icon
            IconButton(
              icon: Icon(Icons.visibility),
              onPressed: () {
                navigateToProductPage(context); // Handle the "View" button tap action here
              },
            ),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(Marketplace());
// }
