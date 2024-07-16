import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF082e1b),
        title: Text("Product Details"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Stack(
              children: [
                Image.asset(
                  "images/Products.jpg", // Replace with your product image
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {
                      // Handle wishlist functionality
                    },
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          CurvedBottomPart(),
        ],
      ),
    );
  }
}

class CurvedBottomPart extends StatefulWidget {
  @override
  _CurvedBottomPartState createState() => _CurvedBottomPartState();
}

class _CurvedBottomPartState extends State<CurvedBottomPart> {
  double _quantity = 1.0;

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Do you want to send the query?'),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the current dialog
                _showSuccessDialog(); // Show the success dialog
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
    );
  }

  Future<void> _showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Your Query has been successfully raised.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(0, -3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product Name",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Category Name", // Add the category name here
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // Text(
                  //   "\$100",
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // Icon(
                  //   Icons.star,
                  //   color: Colors.yellow,
                  // ),
                  // Text(
                  //   "4.5",
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Quantity Slider
                    Text(
                      'Quantity',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: _quantity,
                        min: 1,
                        max: 10,
                        onChanged: (value) {
                          setState(() {
                            _quantity = value;
                          });
                        },
                      ),
                    ),
                    Text(
                      '${_quantity.toStringAsFixed(1)} kg',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                IconLabelRow(icon: Icons.directions_car, label: "Delivery Date"),
                IconLabelRow(icon: Icons.assignment_return, label: "Return Policy days"),
                IconLabelRow(icon: Icons.attach_money, label: "COD available or not"),
              ],
            ),
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showConfirmationDialog();
                },
                child: Text("Raise Query"),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF082e1b),
                  minimumSize: Size(350, 50),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class IconLabelRow extends StatelessWidget {
  final IconData icon;
  final String label;

  IconLabelRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
