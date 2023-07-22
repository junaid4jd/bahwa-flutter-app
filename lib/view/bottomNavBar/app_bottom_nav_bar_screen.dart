import 'dart:io';
import 'package:bahwa_flutter_app/constants.dart';
import 'package:bahwa_flutter_app/profile/profile_screen.dart';
import 'package:bahwa_flutter_app/view/user/cart/cart_screen.dart';
import 'package:bahwa_flutter_app/view/user/userHomeScreen/user_home_screen.dart';
import 'package:bahwa_flutter_app/view_model/getx_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AppBottomNavBarScreen extends StatefulWidget {
  final int index;
  final String title;
  final String subTitle;

  const AppBottomNavBarScreen({Key? key, required this.index, required this.title, required this.subTitle,}) : super(key: key);

  @override
  _AppBottomNavBarScreenState createState() => _AppBottomNavBarScreenState();
}

class _AppBottomNavBarScreenState extends State<AppBottomNavBarScreen> {
  final cartController = Get.put(AddToCartController());
 // final cartController2 = Get.find<AddToCartController>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;
  List<Widget> _pages = [
    //  HomeScreen(),
    // BookingScreen(),
    // ProfileScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int cartTotal = 0;



  getTotal() async {
    setState(() {

      cartTotal = 0;
    });
    FirebaseFirestore.instance
        .collection('UserCart').where('userId', isEqualTo: _auth.currentUser!.uid.toString()).where('productStatus', isEqualTo: 'Pending')
        .get().then((value) {


      for(int i=0 ;i <value.docs.length ; i++) {

        setState(() {
          cartTotal = cartTotal + int.parse(value.docs[i]['productPrice'].toString());
        });
      }


    });
  }

  getToken() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print('customerAccessToken');
    print( _pref.getString('customerAccessToken'));

    print('adminAccessToken');
    print( _pref.getString('adminAccessToken'));
  }

  @override
  void initState() {
    //cartController.fetchCartItems();
    // TODO: implement initState
    super.initState();
    print('UserType');
      setState(() {
        _pages = [
          UserHomeScreen(userType: widget.title,),
          CartScreen(),
          ProfileScreen(userType: widget.title,),
        ];
      });
    print(widget.title.toString());
    getToken();
  }



  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final size = MediaQuery.of(context).size;

    //getToken();
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        backgroundColor: lightGreyColor,
        body: _pages.elementAt(_selectedIndex),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Container(
            height: 55,
            //  color: Colors.white,
            child: SizedBox(
              height: 70,
              child:

              CupertinoTabBar(
                activeColor: primaryColor1,
                currentIndex: _selectedIndex,
                backgroundColor: Colors.white,
                iconSize: 40,
                onTap: _onItemTapped,
                items:
               [
                  orientation == Orientation.portrait
                      ? BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 0;
                            _pages[0] = UserHomeScreen(userType: widget.title,);
                          });
                        },
                        child: Icon(
                          Icons.home_outlined,
                          size: 25,
                          //color: Color(0xFF3A5A98),
                        ),
                      ),
                    ),
                    label: 'Home',
                  )
                      : BottomNavigationBarItem(
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedIndex = 0;
                              //  _pages[0] = HomeScreen();
                              });
                            },
                            child: Icon(
                              Icons.home_outlined,
                              size: 25,
                              //color: Color(0xFF3A5A98),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),

                 orientation == Orientation.portrait
                     ? BottomNavigationBarItem(
                   icon: Padding(
                     padding: EdgeInsets.only(bottom: 4),
                     child: InkWell(
                       onTap: () {
                         setState(() {
                           _selectedIndex = 1;
                           _pages[1] = CartScreen();
                         });
                       },
                       child: Stack(
                           alignment: Alignment.topRight,
                           children:
                           [
                             Icon(Icons.shopping_cart,size: 25,),
                             Positioned(
                               child: Container(
                                 height: 14,
                                 width: 14,
                                 decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: Colors.red,
                                 ),
                                 alignment: Alignment.center,
                                 child:  Obx(()=>Text(cartController.cartItems.toString(),style: caption3White,))
                               ),
                             ),

                           ]

                       )
                     ),
                   ),
                   label: 'Cart',
                 )
                     : BottomNavigationBarItem(
                   icon: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Padding(
                         padding: EdgeInsets.only(bottom: 4),
                         child: InkWell(
                           onTap: () {
                             setState(() {
                               _selectedIndex = 1;
                               //  _pages[0] = HomeScreen();
                             });
                           },
                           child: Icon(
                             Icons.shopping_cart,
                             size: 25,
                             //color: Color(0xFF3A5A98),
                           ),
                         ),
                       ),
                       SizedBox(
                         width: 8,
                       ),
                       Text(
                         'Cart',
                         style: TextStyle(fontSize: 15),
                       )
                     ],
                   ),
                 ),

                  orientation == Orientation.portrait
                      ? BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 2;
                            _pages[2] = ProfileScreen(userType: widget.title.toString(),);
                          });
                        },
                        child: Icon(
                          Icons.account_circle_outlined,
                          size: 25,
                        ),
                      ),
                    ),
                    label: 'Profile',
                  )
                      : BottomNavigationBarItem(
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedIndex = 2;
                                _pages[2] = ProfileScreen(userType: widget.title.toString(),);
                              });
                            },
                            child: Icon(
                              Icons.account_circle_outlined,
                              size: 25,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit the App?'),
        actions:[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: primaryColor,
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:Text('No'),
          ),

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            //return true when click on "Yes"
            style: ElevatedButton.styleFrom(
                primary: redColor,
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            child:Text('Yes'),
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }
}
