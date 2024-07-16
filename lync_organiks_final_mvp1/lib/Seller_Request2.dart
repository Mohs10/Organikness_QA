import 'package:flutter/material.dart';

class RequestPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Request Details'),
          centerTitle: true,
          backgroundColor: Color(0xFF082e1b),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Product Details Flexbox
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product Name',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Category: Category A',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Price: \$50.00',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Quantity: 10',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Address: Dummy Address', // Add dummy address
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),

                    // Accept and Decline Buttons with icons inside the flexbox
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            _showPriceDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF082e1b),
                          ),
                          icon: Icon(Icons.check, color: Colors.white),
                          label: Text('Accept', style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            _showDeclineConfirmationDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          icon: Icon(Icons.close, color: Colors.white),
                          label: Text('Decline', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPriceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Price'),
          content: TextField(
            decoration: InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Handle submit button press
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _showDeclineConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          actions: [
            TextButton(
              onPressed: () {
                // Handle Yes button press
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                // Handle No button press
                Navigator.pop(context); // Close the dialog
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(RequestPage2());
}
