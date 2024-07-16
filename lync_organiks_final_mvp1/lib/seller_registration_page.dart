import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:new_project1/Complete_seller_regd.dart';

class SellerRegistationPage extends StatefulWidget {
  final String uid;

  SellerRegistationPage({required this.uid});

  @override
  State<SellerRegistationPage> createState() => _SellerRegistationPageState();
}

class _SellerRegistationPageState extends State<SellerRegistationPage> {
  final TextEditingController organizationController = TextEditingController();
  final TextEditingController aadharController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkSellerStatus(); // Call this method when the page loads.
  }

  String username = '';
  String mobile = '';
  String address = '';
  String dob = '';
  String gender = '';
  String Uid = '';

  Future<void> checkSellerStatus() async {
    final dio = Dio();
    Response response;
    final String uid = widget.uid;

    try {
      response = await dio.get(
        'http://lyncorganik-env.eba-skd53vix.ap-south-1.elasticbeanstalk.com/organic/user/sellerbuyer/getbyid/$uid',options: Options(
          followRedirects: false,
          validateStatus: (status) { return status! < 500; },
          headers: {
            "Accept" : "application/json"
          }
      ),
      );
      //Response code for 302
      if (response.statusCode == 302) {
        final Map<String, dynamic> responseData = response.data;
        username = responseData['userName'];
        mobile = responseData['mobileNo'];
        address = responseData['address'];
        dob = responseData['dob'];
        gender = responseData['gender'];
        Uid = uid;

        //Response code for 300 to 400
      } else if (response.statusCode! >= 300 && response.statusCode! < 400) {
        // Handle redirection manually
        if (response.headers.value("location") != null) {
          final Map<String, dynamic> responseData = response.data;
          username = responseData['userName'];
          mobile = responseData['mobileNo'];
          address = responseData['address'];
          dob = responseData['dob'];
          gender = responseData['gender'];
          Uid = uid;
        } //Response code for others
        else {
          // Handle the case when the "Location" header is not present
          final Map<String, dynamic> responseData = response.data;
          username = responseData['userName'];
          mobile = responseData['mobileNo'];
          address = responseData['address'];
          dob = responseData['dob'];
          gender = responseData['gender'];
          Uid = uid;
        }
      } else {
        // Handle other error cases
        print("HTTP request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      // Handle network or other errors here
      print("Error in HTTP request: $e");
    }
  }

  Future<void> _registerSeller() async {
    final organization = organizationController.text;
    final adhaar = aadharController.text;

    final dio = Dio();
    final url = 'http://lyncorganik-env.eba-skd53vix.ap-south-1.elasticbeanstalk.com/organic/user/sellerbuyer/add';  // Replace with your API endpoint

    try {
      final response = await dio.post(
        url,
        data: {
          "userName": username,
          "emailId": "",
          "mobileNo": mobile,
          "address": address,
          "certifinNo": "",
          "dob": dob,
          "gender": gender,
          "role":"",
          "organization":organization,
          "aadhaarNo":adhaar,
          "uid":Uid
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CompleteSellerRegdPage(uid: Uid)),
        );
      } else {
        print('Registration failed: ${response.data}');
        // Handle errors, e.g., show an error message to the user.
      }
    } catch (error) {
      print('Error: $error');
      // Handle network errors, e.g., show a connection error message.
    }
  }

  @override
  Widget build(BuildContext context) {
    String uid = widget.uid;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Text(
                "Seller Registration",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF84C86D),
                ),
              ),
              SizedBox(height: 0.0),
              Image.asset(
                'images/Farmer23.png',
                height: 200,
                width: 200,
              ),
              SizedBox(height: 50.0),
              ResponsiveTextFieldWithIcon(
                icon: Icons.business,
                hintText: "Organization",
                controller: organizationController,
              ),
              SizedBox(height: 10.0),
              ResponsiveTextFieldWithIcon(
                icon: Icons.credit_card,
                hintText: "Aadhar Number",
                controller: aadharController,
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: _registerSeller,
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF84C86D),
                  minimumSize: Size(360, 50),
                ),
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResponsiveTextFieldWithIcon extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;

  ResponsiveTextFieldWithIcon({
    required this.icon,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 400),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
