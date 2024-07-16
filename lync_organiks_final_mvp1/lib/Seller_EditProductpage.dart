import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SellerEditProductPage(),
  ));
}

class SellerEditProductPage extends StatelessWidget {
  final TextEditingController harvestDateController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();

  final List<String> categories = ['Category A', 'Category B', 'Category C'];
  final List<String> products = ['Product X', 'Product Y', 'Product Z'];

  String? selectedCategory;
  String? selectedProduct;

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color(0xFF082e1b);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Edit Product",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                buildDropdown(
                  "Select Category",
                  categories,
                  selectedCategory,
                ),
                SizedBox(height: 10),
                buildDropdown(
                  "Select Product",
                  products,
                  selectedProduct,
                ),
                ProductTextField(label: "Price"),
                ProductTextField(label: "Quantity Available"),
                ProductTextField(
                  label: "Harvest Date",
                  controller: harvestDateController,
                  isDateField: true,
                ),
                ProductTextField(
                  label: "Date of Expiry",
                  controller: expiryDateController,
                  isDateField: true,
                ),
                SizedBox(height: 20),
                SaveChangesButton(primaryColor: primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(String label, List<String> items, String? value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: label,
          border: InputBorder.none,
        ),
        value: value,
        onChanged: (newValue) {
          // No state to update in a stateless widget
        },
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController? controller, bool isDateField) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: isDateField
          ? Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                contentPadding: EdgeInsets.all(10),
                suffixIcon: InkWell(
                  onTap: () {
                    // No state to update in a stateless widget
                  },
                  child: Icon(Icons.calendar_today),
                ),
              ),
              readOnly: true,
              onTap: () {
                // No state to update in a stateless widget
              },
            ),
          ),
        ],
      )
          : TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          contentPadding: EdgeInsets.all(10),
        ),
      ),
    );
  }

  Widget buildSubmitButton(Color primaryColor) {
    return ElevatedButton(
      onPressed: () {
        // Implement submission logic here
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(horizontal: 146, vertical: 16),
        ),
        backgroundColor: MaterialStateProperty.all(primaryColor),
      ),
      child: Text("Submit"), // Change to "Save Changes"
    );
  }
}

class ProductTextField extends StatelessWidget {
  final String label;
  final bool isDateField;
  final TextEditingController? controller;

  ProductTextField({
    required this.label,
    this.isDateField = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SellerEditProductPage().buildTextField(
      label,
      controller,
      isDateField,
    );
  }
}

class SaveChangesButton extends StatelessWidget {
  final Color primaryColor;

  SaveChangesButton({required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Implement save changes logic here
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(horizontal: 146, vertical: 16),
        ),
        backgroundColor: MaterialStateProperty.all(primaryColor),
      ),
      child: Text("Save Changes"),
    );
  }
}
