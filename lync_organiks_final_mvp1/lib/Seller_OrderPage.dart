import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SellerOrderPage(),
  ));
}

class SellerOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Orders',
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
                            _showStatusDialog(context);
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

  void _showStatusDialog(BuildContext context) {
    String selectedValue = 'Pending';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Select Status'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 16), // Add height for space
                  DropdownButton<String>(
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedValue = newValue;
                        });
                      }
                    },
                    items: <String>['Pending', 'Shipped', 'Out for Delivery']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16), // Add height for space
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFF082e1b)), // Change color
                        ),
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle save logic here
                          Navigator.of(context).pop(); // Close the status dialog
                          _showSavedNotification(context); // Display "Saved" notification
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFF082e1b)), // Change color
                        ),
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showSavedNotification(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Saved!',
          style: TextStyle(color: Colors.black), // Change text color
        ),
        duration: Duration(seconds: 5),
        backgroundColor: Colors.green, // Change background color
      ),
    );
  }
}
