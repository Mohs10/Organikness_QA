import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'buyer_registration_personalinfo_page.dart';
import 'seller_registration_personalinfo_page.dart';

class VerifyCodePage extends StatefulWidget {
  final String phoneNumber;
  final String role;

  VerifyCodePage({required this.phoneNumber, required this.role});

  @override
  _VerifyCodePageState createState() => _VerifyCodePageState(phoneNumber: phoneNumber);
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final String phoneNumber;
  List<TextEditingController> otpControllers = List.generate(4, (index) => TextEditingController());
  List<FocusNode> otpFocusNodes = List.generate(4, (index) => FocusNode());

  bool isLoading = false;

  _VerifyCodePageState({required this.phoneNumber});

  @override
  void dispose() {
    for (int i = 0; i < 4; i++) {
      otpControllers[i].dispose();
      otpFocusNodes[i].dispose();
    }
    super.dispose();
  }

  Future<void> sendOTPAndNavigateToPersonalInfo() async {
    setState(() {
      isLoading = false;
    });

    final otp = otpControllers.map((controller) => controller.text).join();
    final role = widget.role;

    try {
      //print(phoneNumber);
      final response = await Dio().post(
        'http://lyncorganik-env.eba-skd53vix.ap-south-1.elasticbeanstalk.com/organic/sellerbuyer_registerOtp_verify',
        data: {'phoneNumber': phoneNumber, 'enteredOTP': otp},
      );

      if (response.statusCode == 200) {
        if(role == "Buyer"){
          print(role);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BuyerRegistrationPersonalInfoPage(mobilenumber: phoneNumber,role:role)),
          );
        } else if(role == "Seller") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SellerRegistrationPersonalInfoPage(mobilenumber: phoneNumber,role:role)),
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
    String role = widget.role;
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
                  onPressed: sendOTPAndNavigateToPersonalInfo,
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
