import 'package:flutter/material.dart';
import 'package:new_project1/Seller_AddProduct.dart';
import 'package:new_project1/Seller_EditProductpage.dart';

class SellerProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Product',
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
              // Flexbox Widgets (Dashboard Boxes)
              // ... (Existing code for Flexbox Widgets)

              SizedBox(height: 16), // Add space between flexboxes and the "Add Product" button

              // "Add Product" Button


              SizedBox(height: 16), // Add space below the "Add Product" button

              // Product List
              Expanded(
                child: ListView.builder(
                  itemCount: 5, // Adjust the count based on the number of purchased products
                  itemBuilder: (context, index) {
                    // Replace the below container with your purchased product and delivery status UI
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
                              // Navigate to the Edit page when the button is pressed
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SellerEditProductPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF082e1b),
                            ),
                            child: Text(
                              'Edit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  // Navigate to the respective page when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SellerAddProduct(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF082e1b),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  '+Add Product',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Center(
        child: Text('Edit Product Page'),
      ),
    );
  }
}

void main() {
  runApp(SellerProductPage());
}
