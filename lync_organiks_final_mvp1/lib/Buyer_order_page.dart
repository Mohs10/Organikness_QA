import 'package:flutter/material.dart';

class BuyerOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Order',
              style: TextStyle(color: Colors.black87),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Remove the search product TextField and filter option
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: 5, // Adjust the count based on the number of ordered products
                  itemBuilder: (context, index) {
                    // Replace the below container with your ordered product and status button UI
                    return Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16),
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
                        child: ListTile(
                          onTap: () {
                            // Handle the onTap event
                          },
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.asset(
                              'images/default.png', // Replace with the actual image path
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text('Product Name $index'),
                          subtitle: Text('Category $index'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Handle the Status button press
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF082e1b),
                            ),
                            child: Text(
                              'Status',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// void main() {
//   runApp(OrderPage());
// }
