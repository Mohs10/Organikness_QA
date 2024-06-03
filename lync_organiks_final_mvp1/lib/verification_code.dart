import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:new_project1/Buyer_homepage.dart';
import 'Seller_homepage.dart';
import 'seller_registration_personalinfo_page.dart';

class VerificationCode extends StatefulWidget {
  final String phoneNumber;
  final String role;

  VerificationCode({required this.phoneNumber, required this.role});

  @override
  _VerificationCodeState createState() => _VerificationCodeState(phoneNumber: phoneNumber);
}

class _VerificationCodeState extends State<VerificationCode > {
  final String phoneNumber;
  List<TextEditingController> otpControllers = List.generate(4, (index) => TextEditingController());
  List<FocusNode> otpFocusNodes = List.generate(4, (index) => FocusNode());

  bool isLoading = false;
  bool isAuth = false;

  _VerificationCodeState({required this.phoneNumber});

  @override
  void dispose() {
    for (int i = 0; i < 4; i++) {
      otpControllers[i].dispose();
      otpFocusNodes[i].dispose();
    }
    super.dispose();
  }

  Future<void> sendOTPAndNavigateToHomePage() async {
    setState(() {
      isLoading = false;
    });

    final otp = otpControllers.map((controller) => controller.text).join();
    final role = widget.role;

    try {
      final response = await Dio().post(
        'http://lyncorganik-env.eba-skd53vix.ap-south-1.elasticbeanstalk.com/organic/sellerbuyer_login_verify',
        data: {'phoneNumber': phoneNumber, 'enteredOTP': otp},
      );

      if (response.statusCode == 200 || response.statusCode == 302) {

        final Map<String, dynamic> responseData = response.data;
        final String username = responseData['name'];
        final String address = responseData['sellerBuyer']['address'];
        final String uid = responseData['sellerBuyer']['uid'].toString();

        if(role == "Buyer"){
          print(role);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BuyerHomePage(mobilenumber: phoneNumber, username: username, address: address,uid: uid)),
          );
        } else if(role == "Seller") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SellerHomePage()),
          );
        } else{
          print('Not a valid role.');
        }
      } else {
        print(response.statusCode);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => PersonalInfoPage()),
        // ); // Handle API error here.
      }
    } catch (e) {
      // Handle network or other errors here.
    } finally {
      // setState(() {
      //   isLoading = false;
      // });
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
                'Verification Code',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Image.asset(
                'images/verify.png',
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Text(
                'Please enter the code we just sent to your number',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return buildOtpTextField(index);
                }),
              ),
              SizedBox(height: 20),
              Text(
                'Didn\'t receive OTP?',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Resend OTP action
                },
                child: Text(
                  'Resend OTP',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF84C86D),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: 350,
                child: ElevatedButton(
                  onPressed: sendOTPAndNavigateToHomePage,
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

  Widget buildOtpTextField(int index) {
    return Container(
      width: 50,
      margin: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: otpControllers[index],
        focusNode: otpFocusNodes[index],
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (index < 3) {
              otpFocusNodes[index].unfocus();
              otpFocusNodes[index + 1].requestFocus();
            } else {
              otpFocusNodes[index].unfocus();
              // Perform any desired action when all OTP fields are filled
            }
          }
        },
        decoration: InputDecoration(
          counterText: '', // Remove character count
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
