import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:new_project1/Buyer_homepage.dart';
import 'package:new_project1/Seller_homepage.dart';

class CompleteSellerRegdPage extends StatefulWidget {
  final String uid;

  CompleteSellerRegdPage({required this.uid});

  @override
  State<CompleteSellerRegdPage> createState() => _CompleteSellerRegdPageState();
}

class _CompleteSellerRegdPageState extends State<CompleteSellerRegdPage> {

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

  @override
  Widget build(BuildContext context) {
    String uid = widget.uid.toString();
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          // Handle back button press
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BuyerHomePage(username: username, address: address, mobilenumber: mobile, uid: uid)), // Replace with your homepage class
                (route) => false, // Prevent user from going back to the previous page
          );
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF84C86D),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image Holder
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(75.0),
                  ),
                  child: Image.asset('images/Complete.png'),
                ),
                SizedBox(height: 16.0),

                // "Order Placed Successfully" Text
                Text(
                  'Thank You! We have received Your request.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'You will be navigated to the seller portal based upon the approval from the admin. You will be notified soon.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BuyerHomePage(username: username, address: address, mobilenumber: mobile, uid: uid)), // Replace with your seller homepage class
                    );
                  },
                  child: Text('Back to Buyer Portal'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Color(0xFF84C86D),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(
                        color: Color(0xFF84C86D),
                      ),
                    ),
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
