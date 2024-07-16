import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SellerAddProduct(),
  ));
}

class SellerAddProduct extends StatelessWidget {
  final TextEditingController harvestDateController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();

  final List<String> categories = ['Category A', 'Category B', 'Category C'];
  final List<String> products = ['Product X', 'Product Y', 'Product Z'];

  String? selectedCategory;
  String? selectedProduct;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color(0xFF082e1b);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Add Product",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                  // ProductTextField(label: "Price", isMandatory: true),
                  ProductTextField(label: "Quantity Available", isMandatory: true),
                  ProductTextField(
                    label: "Harvest Date",
                    controller: harvestDateController,
                    isDateField: true,
                    isMandatory: true,
                  ),
                  ProductTextField(
                    label: "Date of Expiry",
                    controller: expiryDateController,
                    isDateField: true,
                    isMandatory: true,
                  ),
                  SizedBox(height: 20),
                  SubmitButton(primaryColor: primaryColor, onPressed: _submitForm),
                ],
              ),
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
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          labelText: label,
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

  Widget buildTextField(String label, TextEditingController? controller, bool isDateField, bool isMandatory) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
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
              validator: (value) {
                if (isMandatory && (value == null || value.isEmpty)) {
                  return 'This field is required';
                }
                return null;
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
        validator: (value) {
          if (isMandatory && (value == null || value.isEmpty)) {
            return 'This field is required';
          }
          return null;
        },
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Implement submission logic here
      // Form is valid
      print('Form is valid');
    }
  }
}

class ProductTextField extends StatelessWidget {
  final String label;
  final bool isDateField;
  final bool isMandatory;
  final TextEditingController? controller;

  ProductTextField({
    required this.label,
    this.isDateField = false,
    this.isMandatory = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SellerAddProduct().buildTextField(label, controller, isDateField, isMandatory);
  }
}

class SubmitButton extends StatelessWidget {
  final Color primaryColor;
  final VoidCallback onPressed;

  SubmitButton({required this.primaryColor, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(horizontal: 146, vertical: 16),
        ),
        backgroundColor: MaterialStateProperty.all(primaryColor),
      ),
      child: Text("Submit"),
    );
  }
}
