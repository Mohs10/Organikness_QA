import 'package:flutter/material.dart';

void main() {
  runApp(OrderStatusPage());
}

class OrderStatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF84C86D),
          title: Text("Order Status"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigate back to the previous screen
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Container for Order Details
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
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
                        color: Colors.grey,
                        image: DecorationImage(
                          image: AssetImage('images/Oilseed2.png'), // Replace with your image path
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
                            'Product Name',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Product ID: 0122'),
                          Text('Quantity: 1 kg'),
                          Text('Order Placed: 1 Aug 2023'),
                          Text('Delivery Date: 20 Aug 2023'),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    // Right column for price
                    Text(
                      'Rs. 660',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              // Container for "Order Status" and the flow
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Order Status',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 200.0, // Adjust the height as needed
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          buildStatusItem('Confirmed', '1 Aug 2023', true),
                          buildStatusItem('Packed', '2 Aug 2023', true),
                          buildStatusItem('Shipped', '5 Aug 2023', true),
                          buildStatusItem('Out for Delivery', '15 Aug 2023', false),
                          buildStatusItem('Delivered by', '20 Aug 2023', false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              // "Need Help with your Order?" text and message icon
              ElevatedButton(
                onPressed: () {
                  // Handle help button tap action here
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF84C86D), // Button color
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.message, color: Colors.white), // Icon with white color
                    Text("Need help with your Order?", style: TextStyle(color: Colors.white)),
                    SizedBox(width: 8.0),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build order status items in a vertical flow
  Widget buildStatusItem(String status, String date, bool isActive) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? Color(0xFF84C86D) : Colors.grey,
            ),
          ),
          SizedBox(height: 8.0),
          Text(status, style: TextStyle(fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
          Text(date, style: TextStyle(fontSize: 12.0, color: Colors.grey)),
        ],
      ),
    );
  }
}
