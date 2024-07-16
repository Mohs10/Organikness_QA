// import 'package:flutter/material.dart';
// import 'package:new_project1/Market_place.dart';
//
// class OrderPlacedPage extends StatefulWidget {
//   final String username;
//   final String address;
//   final String mobilenumber;
//   final String uid;
//
//   OrderPlacedPage({required this.username,required this.address,required this.mobilenumber, required this.uid});
//
//   @override
//   State<OrderPlacedPage> createState() => _OrderPlacedPageState();
// }
//
// class _OrderPlacedPageState extends State<OrderPlacedPage> {
//   @override
//   Widget build(BuildContext context) {
//     String username = widget.username;
//     String address = widget.address;
//     String mobilenumber = widget.mobilenumber;
//     String uid = widget.uid;
//     //final Map<String, dynamic> responseData = widget.responseData;
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color(0xFF84C86D), // Navbar color
//           // title: Text("Order Placed"),
//           centerTitle: true,
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Image Holder
//               Container(
//                 width: 150.0,
//                 height: 150.0,
//                 decoration: BoxDecoration(
//                   color: Colors.grey, // Placeholder color
//                   borderRadius: BorderRadius.circular(75.0), // Circular shape
//                 ),
//                 // You can replace the 'imagePath' with your actual image asset path
//                 child: Image.asset('images/Placed2.png'), // Replace with your image
//               ),
//               SizedBox(height: 16.0),
//
//               // "Order Placed Successfully" Text
//               Text(
//                 'Order Placed Successfully',
//                 style: TextStyle(
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 32.0),
//
//               // "Continue Shopping" Button
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Marketplace(username: username, address: address, mobilenumber: mobilenumber, uid: uid,responseData: ,)), // Replace 'DestinationPage' with your actual destination page class
//                   );// Implement navigation to shopping page or any desired action
//                 },
//                 child: Text('Continue Shopping'),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.white, // Button background color
//                   onPrimary: Color(0xFF84C86D), // Button stroke (highlight) color
//                   elevation: 2.0, // Button elevation
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0), // Rounded corners
//                     side: BorderSide(
//                       color: Color(0xFF84C86D), // Button stroke (highlight) color
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // void main() {
// //   runApp(OrderPlacedPage());
// // }
