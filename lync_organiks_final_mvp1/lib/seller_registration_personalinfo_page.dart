import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'Complete_seller_regd.dart';
import 'complete_profile.dart';

class SellerRegistrationPersonalInfoPage extends StatefulWidget {
  final String mobilenumber;
  final String role;

  SellerRegistrationPersonalInfoPage({required this.mobilenumber, required this.role});

  @override
  _SellerRegistrationPersonalInfoPageState createState() => _SellerRegistrationPersonalInfoPageState();
}

class _SellerRegistrationPersonalInfoPageState extends State<SellerRegistrationPersonalInfoPage> {
  String selectedGender = 'Select Gender';
  List<String> genderOptions = ['Select Gender', 'Male', 'Female', 'Other'];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController organizationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dateofbirthController = TextEditingController();
  final TextEditingController adhaarController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    String mobilenumber = widget.mobilenumber;

    Future<void> submitPersonalInfo() async {
      setState(() {
        isLoading = true;
      });

      final name = nameController.text;
      final organization = organizationController.text;
      final address = addressController.text;
      final dateofbirth = dateofbirthController.text;
      final adhaar = adhaarController.text;
      final role = widget.role;

      try {
        print("hello");
        final response = await Dio().post(
          'http://lyncorganik-env.eba-skd53vix.ap-south-1.elasticbeanstalk.com/organic/user/sellerbuyer/add',
          data: {
            "userName": name,
            "emailId": "a@a.com",
            "mobileNo": mobilenumber,
            "address": address,
            "certifinNo": "12345",
            "dob": dateofbirth,
            "gender": selectedGender,
            "role":role,
            "organization":organization,
            "aadhaarNo":adhaar
          },
        );

        if (response.statusCode == 201) {
          final Map<String, dynamic> responseData = response.data;
          final String uid = responseData['uid'].toString();

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CompleteSellerRegdPage(uid: uid,)),
          );
        } else {
          // Handle API error here.
          print(response.statusCode);
        }
      } catch (e) {
        print(e);
        print(dateofbirth);
        // Handle network or other errors here.
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF84C86D),
        title: Text(
          'Seller Registration',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/personal.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              buildTextField('Name', Icons.person, nameController),
              SizedBox(height: 10),
              buildTextField('Organization', Icons.business, organizationController),
              SizedBox(height: 10),
              buildTextField('Address', Icons.location_city, addressController),
              SizedBox(height: 10),
              buildTextField('Adhaar', Icons.credit_card_rounded, adhaarController),
              SizedBox(height: 10),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    child: TextFormField(
                      readOnly: true,
                      controller: dateofbirthController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        hintText: 'Enter DOB',
                        prefixIcon: Icon(Icons.calendar_month),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            // Show date picker when the calendar icon is clicked
                            _selectDate(context, dateofbirthController);
                          },
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              buildGenderDropdown(),
              SizedBox(height: 20),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: 350,
                child: ElevatedButton(
                  onPressed: submitPersonalInfo,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF84C86D),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text("Sign Up"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: 'Enter $labelText',
          prefixIcon: Icon(icon),
          // suffixIcon: IconButton(
          //   //icon: Icon(Icons.calendar_today),
          //   onPressed: () {
          //     // Show date picker when the calendar icon is clicked
          //     _selectDate(context, controller);
          //   },
          // ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      final formattedDate = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      controller.text = formattedDate.toString(); // Set the selected date in the text field
    }
  }

  Widget buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButtonFormField(
        value: selectedGender,
        onChanged: (newValue) {
          setState(() {
            selectedGender = newValue.toString();
          });
        },
        items: genderOptions.map((gender) {
          return DropdownMenuItem(
            value: gender,
            child: Text(gender),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: 'Gender',
          prefixIcon: Icon(Icons.person_outline),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
