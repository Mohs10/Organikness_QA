//import 'dart:js';

//import 'dart:js';
import 'package:onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:new_project1/Order_page.dart';
import 'welcom_screen.dart';
import 'Log_in.dart';
import 'verification_code.dart';
import 'signup_page.dart';
import 'seller_registration_personalinfo_page.dart';
import 'verifycode_page.dart';
import 'complete_profile.dart';
import 'package:new_project1/Buyer_homepage.dart';
import 'package:new_project1/Market_place.dart';
import 'Account_profile.dart';
import 'package:new_project1/Order_page.dart';
import 'package:new_project1/Ordernew_page.dart';
// import 'package:new_project1/Product_details.dart';
// import 'package:new_project1/Sample_order.dart';
// import 'package:new_project1/Add_delivery_addresspage.dart';
import 'package:new_project1/Order_Placed.dart';
// import 'package:new_project1/Final_Order_page.dart';
import 'package:new_project1/Notifications_page.dart';
import 'package:new_project1/Marketpage_place.dart';

import 'package:new_project1/Seller_welcome_screen.dart';
import 'package:new_project1/seller_registration_page.dart';
import 'package:new_project1/Complete_seller_regd.dart';
import 'package:new_project1/Seller_homepage.dart';
import 'package:new_project1/Seller_ProductPage.dart';
import 'package:new_project1/Seller_AddProduct.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:new_project1/About_us.dart';
import 'package:new_project1/Profile_page.dart';
import 'package:new_project1/Querypage.dart';
import 'package:new_project1/Product_details.dart';
import 'package:new_project1/Buyer_order_page.dart';
import 'package:onboarding/onboarding.dart';


void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: WelcomeScreen(),
//     );
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Material materialButton;
  late int index;
  final onboardingPagesList = [
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.0,
            color: Colors.white,
          ),
        ),
        child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
                children: <Widget>[
                  Container(
                    height: 500,
                    child: Image.asset(
                      'images/e.jpg', // Replace with your image path
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              // style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Agriculture, Simplified:                  ",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    // Color for the text before "perfect platform"
                                  ),
                                ),
                                TextSpan(
                                  text: "Join Our Platform with a Click",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF84C86D), // Color for "perfect platform"
                                  ),
                                ),
                                // TextSpan(
                                //   text: " for your space!",
                                //   style: TextStyle(
                                //     fontSize: 22,
                                //     fontWeight: FontWeight.bold,
                                //     color: Colors.black, // Color for the text after "perfect platform"
                                //   ),
                                // ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),

                          // textAlign: TextAlign.center,
                          //             ),
                          SizedBox(height: 20),


                          Text(
                            "Your Path to Crop Abundance Starts Here, with a Few Quick Moves.",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),

                        ]
                    ),
                  ),
                ]
            )
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.0,
            color: Colors.white,
          ),
        ),
        child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
                children: <Widget>[
                  Container(
                    height: 500,
                    child: Image.asset(
                      'images/e.jpg', // Replace with your image path
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              // style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Effortless Access to Diverse Crop Categories",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    // Color for the text before "perfect platform"
                                  ),
                                ),
                                TextSpan(
                                  text: " –Your Way to Farming Success!",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF84C86D), // Color for "perfect platform"
                                  ),
                                ),

                                // TextSpan(
                                //   text: " for your space!",
                                //   style: TextStyle(
                                //     fontSize: 22,
                                //     fontWeight: FontWeight.bold,
                                //     color: Colors.black, // Color for the text after "perfect platform"
                                //   ),
                                // ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),

                          // textAlign: TextAlign.center,
                          //             ),
                          SizedBox(height: 20),

                          Text(
                            "Your Path to Crop Abundance Starts Here, with a Few Quick Moves.",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 20),
                          SizedBox(height: 20),

                        ]
                    ),
                  ),
                ]
            )
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.0,
            color: Colors.white,
          ),
        ),
        child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
                children: <Widget>[
                  Container(
                    height: 500,
                    child: Image.asset(
                      'images/Onboarding1.png', // Replace with your image path
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              // style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Crop Variety Made Simple:     ",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    // Color for the text before "perfect platform"
                                  ),
                                ),
                                TextSpan(
                                  text: "Explore Categories in a Few Swift Clicks",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF84C86D), // Color for "perfect platform"
                                  ),
                                ),

                                // TextSpan(
                                //   text: " for your space!",
                                //   style: TextStyle(
                                //     fontSize: 22,
                                //     fontWeight: FontWeight.bold,
                                //     color: Colors.black, // Color for the text after "perfect platform"
                                //   ),
                                // ),


                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),

                          // textAlign: TextAlign.center,
                          //             ),
                          SizedBox(height: 20),

                          Text(
                            "Your Path to Crop Abundance Starts Here, with a Few Quick Moves.",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),


                          SizedBox(height: 20),
                          SizedBox(height: 20),

                        ]
                    ),
                  ),
                ]
            )
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    materialButton = _skipButton();
    index = 0;
  }

  Material _skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      color:  Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          if (setIndex != null) {
            index = 2;
            setIndex(2);
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Skip to End',
            style: TextStyle(
              fontWeight: FontWeight.w500, color: Color(0xFF84C86D), // Set the text to bold
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Material get _signupButton {
    return Material(
      // borderRadius: defaultProceedButtonBorderRadius,
      color: Color(0xFF84C86D),
      child: ElevatedButton(
        onPressed: () {
          print("Hello");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()), // Replace 'DestinationPage' with your actual destination page class
          );
        },

        style: ElevatedButton.styleFrom(
          //primary: Color(0xFFFFFF),
          backgroundColor:Color(0xFFFFFF),
          // Set the background color to #84C86D
        ),
        child: Text("Get Started"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      //title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Onboarding(
          pages: onboardingPagesList,
          onPageChange: (int pageIndex) {
            index = pageIndex;
          },
          startPageIndex: 0,
          footerBuilder: (context, dragDistance, pagesLength, setIndex) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 0.0,
                  color: background,
                ),
              ),
              child: ColoredBox(
                color: Color(0xFF84C86D),
                child: Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIndicator(
                          netDragPercent: dragDistance,
                          pagesLength: pagesLength,
                          indicator: Indicator(
                            indicatorDesign: IndicatorDesign.polygon(
                              polygonDesign: PolygonDesign(
                                polygon: DesignType.polygon_circle,
                                // color: Colors.blue,
                              ),
                            ),
                          )
                      ),
                      index == pagesLength - 1
                          ? _signupButton
                          : _skipButton(setIndex: setIndex)
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   late Material materialButton;
//   late int index;
//   final onboardingPagesList = [
//     PageModel(
//       widget: DecoratedBox(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(
//             width: 0.0,
//             color: Colors.white,
//           ),
//         ),
//         child: SingleChildScrollView(
//           controller: ScrollController(),
//           child: Column(
//               children: <Widget>[
//                 Container(
//                   height: 500,
//                   child: Image.asset(
//                     'images/Onboarding2.png', // Replace with your image path
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(20),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         RichText(
//                           text: TextSpan(
//                             // style: DefaultTextStyle.of(context).style,
//                             children: <TextSpan>[
//                               TextSpan(
//                                 text: "Agriculture, Simplified:                  ",
//                                 style: TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black,
//                                   // Color for the text before "perfect platform"
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: "Join Our Platform with a Click",
//                                 style: TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xFF84C86D), // Color for "perfect platform"
//                                 ),
//                               ),
//                               // TextSpan(
//                               //   text: " for your space!",
//                               //   style: TextStyle(
//                               //     fontSize: 22,
//                               //     fontWeight: FontWeight.bold,
//                               //     color: Colors.black, // Color for the text after "perfect platform"
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//
//                         // textAlign: TextAlign.center,
//                         //             ),
//                         SizedBox(height: 20),
//
//
//                         Text(
//                           "Your Path to Crop Abundance Starts Here, with a Few Quick Moves.",
//                           style: TextStyle(
//                             fontSize: 16,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         SizedBox(height: 20),
//                         SizedBox(height: 20),
//
//                       ]
//                   ),
//                 ),
//               ]
//           )
//         ),
//       ),
//     ),
//     PageModel(
//       widget: DecoratedBox(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(
//             width: 0.0,
//             color: Colors.white,
//           ),
//         ),
//         child: SingleChildScrollView(
//             controller: ScrollController(),
//             child: Column(
//                 children: <Widget>[
//                   Container(
//                     height: 500,
//                     child: Image.asset(
//                       'images/Onboarding3.png', // Replace with your image path
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(20),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           RichText(
//                             text: TextSpan(
//                               // style: DefaultTextStyle.of(context).style,
//                               children: <TextSpan>[
//                                 TextSpan(
//                                   text: "Effortless Access to Diverse Crop Categories      ",
//                                   style: TextStyle(
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                     // Color for the text before "perfect platform"
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: "– Your Way to Farming Success!",
//                                   style: TextStyle(
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF84C86D), // Color for "perfect platform"
//                                   ),
//                                 ),
//
//                                 // TextSpan(
//                                 //   text: " for your space!",
//                                 //   style: TextStyle(
//                                 //     fontSize: 22,
//                                 //     fontWeight: FontWeight.bold,
//                                 //     color: Colors.black, // Color for the text after "perfect platform"
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//
//                           // textAlign: TextAlign.center,
//                           //             ),
//                           SizedBox(height: 20),
//                           // Text(
//                           //   "Get access to a wide variety of Catagories of crops with just a few steps.",
//                           //   style: TextStyle(
//                           //     fontSize: 16,
//                           //   ),
//                           //   textAlign: TextAlign.center,
//                           // ),
//                           SizedBox(height: 20),
//                           SizedBox(height: 20),
//
//                         ]
//                     ),
//                   ),
//                 ]
//             )
//         ),
//       ),
//     ),
//     PageModel(
//       widget: DecoratedBox(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(
//             width: 0.0,
//             color: Colors.white,
//           ),
//         ),
//         child: SingleChildScrollView(
//             controller: ScrollController(),
//             child: Column(
//                 children: <Widget>[
//                   Container(
//                     height: 500,
//                     child: Image.asset(
//                       'images/Onboarding1.png', // Replace with your image path
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(20),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           RichText(
//                             text: TextSpan(
//                               // style: DefaultTextStyle.of(context).style,
//                               children: <TextSpan>[
//                                 TextSpan(
//                                   text: "Crop Variety Made Simple:     ",
//                                   style: TextStyle(
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                     // Color for the text before "perfect platform"
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: "Explore Categories in a Few Swift Clicks",
//                                   style: TextStyle(
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF84C86D), // Color for "perfect platform"
//                                   ),
//                                 ),
//
//                                 // TextSpan(
//                                 //   text: " for your space!",
//                                 //   style: TextStyle(
//                                 //     fontSize: 22,
//                                 //     fontWeight: FontWeight.bold,
//                                 //     color: Colors.black, // Color for the text after "perfect platform"
//                                 //   ),
//                                 // ),
//
//
//                               ],
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//
//                           // textAlign: TextAlign.center,
//                           //             ),
//                           SizedBox(height: 20),
//
//                           // Text(
//                           //   "Get access to a wide variety of Catagories of crops with just a few steps.",
//                           //   style: TextStyle(
//                           //     fontSize: 16,
//                           //   ),
//                           //   textAlign: TextAlign.center,
//                           // ),
//
//
//                           SizedBox(height: 20),
//                           SizedBox(height: 20),
//
//                         ]
//                     ),
//                   ),
//                 ]
//             )
//         ),
//       ),
//     ),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     materialButton = _skipButton();
//     index = 0;
//   }
//
//   Material _skipButton({void Function(int)? setIndex}) {
//     return Material(
//       borderRadius: defaultSkipButtonBorderRadius,
//       color:  Color(0xFF84C86D),
//       child: InkWell(
//         borderRadius: defaultSkipButtonBorderRadius,
//         onTap: () {
//           if (setIndex != null) {
//             index = 2;
//             setIndex(2);
//           }
//         },
//         child: const Padding(
//           padding: defaultSkipButtonPadding,
//           child: Text(
//             'Skip',
//             style: defaultSkipButtonTextStyle,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Material get _signupButton {
//     return Material(
//       //borderRadius: defaultProceedButtonBorderRadius,
//       color: Color(0xFF84C86D),
//       child: ElevatedButton(
//         onPressed: () {
//           print("Hello");
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => SignupPage()), // Replace 'DestinationPage' with your actual destination page class
//           );
//         },
//
//         style: ElevatedButton.styleFrom(
//           primary: Color(0xFF84C86D), // Set the background color to #84C86D
//         ),
//         child: Text("Get Started"),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       //debugShowCheckedModeBanner: false,
//       //title: 'Flutter Demo',
//       theme: ThemeData(
//         //primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: Scaffold(
//         body: Onboarding(
//           pages: onboardingPagesList,
//           onPageChange: (int pageIndex) {
//             index = pageIndex;
//           },
//           startPageIndex: 0,
//           footerBuilder: (context, dragDistance, pagesLength, setIndex) {
//             return DecoratedBox(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   width: 0.0,
//                   color: background,
//                 ),
//               ),
//               child: ColoredBox(
//                 color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.all(45.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       CustomIndicator(
//                         netDragPercent: dragDistance,
//                         pagesLength: pagesLength,
//                           indicator: Indicator(
//                             indicatorDesign: IndicatorDesign.polygon(
//                               polygonDesign: PolygonDesign(
//                                 polygon: DesignType.polygon_circle,
//                                 // color: Colors.blue,
//                               ),
//                             ),
//                           )
//                       ),
//                       index == pagesLength - 1
//                           ? _signupButton
//                           : _skipButton(setIndex: setIndex)
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }



