import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:new_project1/signup_page.dart';
import 'verification_code.dart';

class LoginPage extends StatefulWidget {

  final String role;

  LoginPage({required this.role});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneNumberController = TextEditingController();
  bool isLoading = false;

  void login() async {
    setState(() {
      isLoading = true;
    });

    final phoneNumber = phoneNumberController.text;
    final role = widget.role;

    try {
      final response = await Dio().post(
        'http://lyncorganik-env.eba-skd53vix.ap-south-1.elasticbeanstalk.com/organic/sellerbuyer_login', // Replace with your API endpoint
        data: {'phoneNumber': phoneNumber},
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationCode(phoneNumber: phoneNumber, role: role,),
          ),
        );
      } else {
        // print('Login failed. Status code: ${response.statusCode}');
        // Handle login failure (show an error message, etc.)
      }
    } catch (e) {
      // print('Error: $e');
      // Handle network or other errors here.
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Image.asset(
                'images/login_page.png', // Replace with your image path
                width: 500,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Text(
                'Enter your 10-digit mobile number to continue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    hintText: 'Enter your 10-digit mobile number',
                    prefixIcon: Icon(Icons.phone, color: Color(0xFF84C86D)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF84C86D),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Color(0xFF84C86D),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: 350,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF84C86D),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text("LOGIN"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
