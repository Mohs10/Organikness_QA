import 'package:flutter/material.dart';
import 'package:new_project1/Buyer_homepage.dart';

class CompleteprofilePage extends StatefulWidget {
  final String username;
  final String address;
  final String mobilenumber;
  final String uid;
  final String role;

  CompleteprofilePage({required this.username,required this.address,required this.mobilenumber, required this.uid, required this.role});

  @override
  _CompleteprofilePageState createState() => _CompleteprofilePageState();
}

class _CompleteprofilePageState extends State<CompleteprofilePage> {
  @override
  Widget build(BuildContext context) {
    String username = widget.username;
    String address = widget.address;
    String mobilenumber = widget.mobilenumber;
    String uid = widget.uid;
    String role = widget.role;
    return WillPopScope(
      onWillPop: () async {
        // Prevent going back to the CompleteprofilePage.
        return false;
      },
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF84C86D),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Congratulations, ",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "${username}! ",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF84C86D),
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
                  child: Image.asset('images/Pro_completed.png'),
                ),
                SizedBox(height: 16.0),
                Text(
                  'You are now a registered user on LYNC.',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BuyerHomePage(username: username,address: address,mobilenumber: mobilenumber, uid: uid)),
                    );
                  },
                  child: Text('Click to HomePage'),
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
