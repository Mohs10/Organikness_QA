import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'verifycode_page.dart';

class SignupPage extends StatefulWidget {
  final String role;

  SignupPage({required this.role});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> sendMobileNumberAndGenerateOTP() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final mobileNumber = mobileController.text;
      final role = widget.role;

      try {
        final response = await Dio().post('http://lyncorganik-env.eba-skd53vix.ap-south-1.elasticbeanstalk.com/organic/sellerbuyer_registerNumber', data: {
          'phoneNumber': mobileNumber,
        });

        final Map<String, dynamic> responseData = response.data;
        final String message = responseData['message'];

        if (response.statusCode == 200 && message!='Number already exists.') {
          print(response.statusCode);
          print(mobileNumber);
          print(role);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VerifyCodePage(phoneNumber: mobileNumber,role: role,)),
          );
        } else if (response.statusCode == 200 && message=='Number already exists.') {
          print(message);
        } else {
          print(response.statusMessage);
        }
      } catch (e) {
        // Handle network or other errors here.
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String role = widget.role;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Welcome to ",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "Lync Organiks",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF84C86D),
                        ),
                      ),
                      TextSpan(
                        text: "!",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Image.asset(
                  'images/welcome.png',
                  height: MediaQuery.of(context).size.height * 0.4,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 10),
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
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid 10-digit mobile number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      hintText: 'Enter your 10-digit mobile number',
                      prefixIcon: Icon(Icons.phone, color: Color(0xFF84C86D)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF84C86D)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                      labelStyle: TextStyle(color: Color(0xFF84C86D)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  width: 350,
                  child: ElevatedButton(
                    onPressed: sendMobileNumberAndGenerateOTP,
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF84C86D),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text("Get OTP"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
