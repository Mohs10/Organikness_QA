import 'package:flutter/material.dart';

import 'Seller_Request2.dart';

class SellerRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Request',
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
              SizedBox(height: 16),

              // Product List
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
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
                            _navigateToProductDetail(context, index);
                          },
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.asset(
                              'images/default.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text('Product Name $index'),
                          subtitle: Text('Category $index'),

                          trailing: ElevatedButton(
                            onPressed: () {
                              // Handle the "View" button press
                              _navigateToProductDetail(context, index);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF082e1b),
                            ),
                            child: Text(
                              'View',
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

  // Method to navigate to the ProductDetailPage
  void _navigateToProductDetail(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RequestPage2()),
    );
  }
}



void main() {
  runApp(SellerRequestPage());
}
