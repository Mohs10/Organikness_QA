import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:new_project1/Account_profile.dart';
import 'package:new_project1/Notifications_page.dart';
import 'package:new_project1/Ordernew_page.dart';
import 'package:new_project1/Buyer_homepage.dart';
import 'package:new_project1/Market_place.dart';
import 'package:new_project1/Seller_welcome_screen.dart';

import 'Complete_seller_regd.dart';
import 'Seller_homepage.dart';

class OrderPage extends StatefulWidget {
  final String username;
  final String address;
  final String mobilenumber;
  final String uid;

  OrderPage({required this.username,required this.address,required this.mobilenumber, required this.uid});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

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
        final bool enableStatus = responseData['enabled'];
        final String? adhaarStatus = responseData['aadhaarNo'];
        print(responseData);
        print(adhaarStatus);
        if(enableStatus == false && adhaarStatus==null){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeSellerPage(uid: uid,)),
          );
        }else if(enableStatus == false && adhaarStatus!=null){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CompleteSellerRegdPage(uid: uid,)),
          );
        } else if(enableStatus == true && adhaarStatus!=null){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SellerHomePage()),
          );
        } else {
          return null;
        }
        //Response code for 300 to 400
      } else if (response.statusCode! >= 300 && response.statusCode! < 400) {
        // Handle redirection manually
        if (response.headers.value("location") != null) {
          final Map<String, dynamic> responseData = response.data;
          final bool enableStatus = responseData['enabled'];
          final String? adhaarStatus = responseData['aadhaarNo'];
          print(responseData);
          print(adhaarStatus);
          if(enableStatus == false && adhaarStatus==null){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomeSellerPage(uid: uid,)),
            );
          }else if(enableStatus == false && adhaarStatus!=null){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CompleteSellerRegdPage(uid: uid,)),
            );
          } else if(enableStatus == true && adhaarStatus!=null){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SellerHomePage()),
            );
          } else {
            return null;
          }
        } //Response code for others
        else {
          // Handle the case when the "Location" header is not present
          final Map<String, dynamic> responseData = response.data;
          final bool enableStatus = responseData['enabled'];
          final String? adhaarStatus = responseData['aadhaarNo'];
          print(responseData);
          print(enableStatus);
          print(adhaarStatus);
          if(enableStatus == false && adhaarStatus==null){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomeSellerPage(uid: uid,)),
            );
          }else if(enableStatus == false && adhaarStatus!=null){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CompleteSellerRegdPage(uid: uid,)),
            );
          } else if(enableStatus == true && adhaarStatus!=null){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SellerHomePage()),
            );
          } else {
            return null;
          }
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
    String username = widget.username;
    String address = widget.address;
    String mobilenumber = widget.mobilenumber;
    String uid = widget.uid;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF84C86D),
          title: Text("Orders"),
          // leading: IconButton(
          //   icon: Icon(Icons.menu),
          //   onPressed: () {
          //       // Navigator.push(
          //       //   context,
          //       //   MaterialPageRoute(builder: (context) => AccountPage()), // Replace 'DestinationPage' with your actual destination page class
          //       // );
          //   },
          // ),
          actions: [
            // IconButton(
            //   icon: Icon(Icons.notifications),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => NotificationsPage()), // Replace 'DestinationPage' with your actual destination page class
            //     );
            //   },
            // ),
          ],
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "We will be ",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "Live Soon ",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF84C86D),
                      ),
                    ),
                    TextSpan(
                      text: "!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(75.0),
                ),
                child: Image.asset('images/comingsoon.png'),
              ),
              SizedBox(height: 16.0),
              // Text(
              //   'Welcome ${username}',
              //   style: TextStyle(
              //     fontSize: 20.0,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              SizedBox(height: 32.0),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => HomePage(username: username,address: address,mobilenumber: mobilenumber,)),
              //     );
              //   },
              //   child: Text('Click to HomePage'),
              //   style: ElevatedButton.styleFrom(
              //     primary: Colors.white,
              //     onPrimary: Color(0xFF84C86D),
              //     elevation: 2.0,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8.0),
              //       side: BorderSide(
              //         color: Color(0xFF84C86D),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 3,
          selectedItemColor: Color(0xFF84C86D),
          onTap: (index) {
            if (index == 0) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BuyerHomePage(username: username, address: address, mobilenumber: mobilenumber, uid: uid),
              ));
            }else if (index == 1) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Marketplace(username: username, address: address, mobilenumber: mobilenumber, uid: uid),
              ));
            } else if (index == 2) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OrderPage(username: username, address: address, mobilenumber: mobilenumber, uid: uid,),
              ));
            } else if (index == 3) {
              checkSellerStatus();
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Marketplace",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: "Seller",
            ),
          ],
        ),
      ),
    );
  }
}




// void main() {
//   runApp(OrderPageApp());
// }
