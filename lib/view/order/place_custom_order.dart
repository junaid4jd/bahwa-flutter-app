import 'dart:math';

import 'package:bahwa_flutter_app/constants.dart';
import 'package:bahwa_flutter_app/res/app_assets.dart';
import 'package:bahwa_flutter_app/res/colors.dart';
import 'package:bahwa_flutter_app/utils/routes/routes_name.dart';
import 'package:bahwa_flutter_app/view/bottomNavBar/app_bottom_nav_bar_screen.dart';
import 'package:bahwa_flutter_app/view_model/firebase_auth.dart';
import 'package:bahwa_flutter_app/view_model/input_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceCustomOrder extends StatefulWidget {
  const PlaceCustomOrder({super.key});

  @override
  State<PlaceCustomOrder> createState() => _PlaceCustomOrderState();
}

class _PlaceCustomOrderState extends State<PlaceCustomOrder> {

  final TextEditingController _titleControoler = TextEditingController();
  final TextEditingController _glassHeightControoler = TextEditingController();
  final TextEditingController _glassWidthControoler = TextEditingController();
  final TextEditingController _glassTypeControoler = TextEditingController();
  final TextEditingController _quantityControoler = TextEditingController();
  final TextEditingController _addressControoler = TextEditingController();
  final TextEditingController _passwordControoler = TextEditingController();
  final TextEditingController _confirmPasswordControoler = TextEditingController();

  String orderCode = '',name = '',email = '',uid = '', userType =  '';
  MethodsHandler _methodsHandler = MethodsHandler();
  InputValidator _inputValidator = InputValidator();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String,dynamic>> _productsListForPost = [];

  bool _isLoading = false;
  bool _isVisible = false;
  bool _isVisibleC = false;



  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _isVisible = false;
      _isVisibleC = false;
      _isLoading = false;
    });
    getUserData();
    super.initState();
  }
  getUserData() async {
    await FirebaseFirestore.instance
        .collection('Users').where('uid', isEqualTo: _auth.currentUser!.uid.toString()).get().then((value) {
          setState(() {
            email = value.docs[0]['email'];
            name = value.docs[0]['name'];
            uid = _auth.currentUser!.uid.toString();
          });

    });

    print(email.toString() + ' uid');
    print(name.toString());
    print(uid.toString());
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      //resizeToAvoidBottomInset: false,
      body:    SingleChildScrollView(
        child: Container(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [


              Container(

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)
                    )
                ),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [

                      GestureDetector(
                        onTap:() {
                          print('tapping to remove');
                          Navigator.pushNamed(context, RoutesName.home);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: size.width*0.95,
                            child: IconButton(onPressed: () {
                              print('tapping to remove');
                             // Navigator.pushNamed(context, RoutesName.welcome, arguments: widget.userType);

                            }, icon: Icon(Icons.arrow_back, color: AppColors.darkRedColor,size: 20,)),

                          ),
                        ),
                      ),

                      Center(
                        child: SizedBox(
                          height: 80,
                          width: size.width*0.8,
                          child: Image.asset(AppAssets.logo, fit: BoxFit.scaleDown,
                            height: 100,
                            width: size.width*0.8,),
                        ),
                      ),

                      SizedBox(
                        height: size.height*0.01,
                      ),

                      Center(
                          child: Text('Custom Order', style: TextStyle(color: Color(0xFF585858), fontSize: 16,fontWeight: FontWeight.bold),)
                      ),

                      SizedBox(
                        height: size.height*0.05,
                      ),


                      Container(
                        margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                        child: TextFormField(
                          controller: _titleControoler,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,

                          ),
                          onChanged: (value) {
                            // setState(() {
                            //   userInput.text = value.toString();
                            // });
                          },
                          decoration: InputDecoration(
                            //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            focusColor: Colors.white,
                            //add prefix icon

                            // errorText: "Error",

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: darkGreyTextColor1, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: Colors.grey,
                            hintText: "",

                            //make hint text
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: "verdana_regular",
                              fontWeight: FontWeight.w400,
                            ),

                            //create lable
                            labelText: 'Title',
                            //lable style
                            labelStyle: TextStyle(
                              color: darkRedColor,
                              fontSize: 16,
                              fontFamily: "verdana_regular",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height*0.02,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                        child: TextFormField(
                          controller: _glassHeightControoler,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,

                          ),
                          onChanged: (value) {
                            // setState(() {
                            //   userInput.text = value.toString();
                            // });
                          },
                          decoration: InputDecoration(
                            //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            focusColor: Colors.white,
                            //add prefix icon

                            // errorText: "Error",

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: darkGreyTextColor1, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: Colors.grey,
                            hintText: "",

                            //make hint text
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: "verdana_regular",
                              fontWeight: FontWeight.w400,
                            ),

                            //create lable
                            labelText: 'Glass Height',
                            //lable style
                            labelStyle: TextStyle(
                              color: darkRedColor,
                              fontSize: 16,
                              fontFamily: "verdana_regular",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height*0.02,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                        child: TextFormField(
                          controller: _glassWidthControoler,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          onChanged: (value) {
                            // setState(() {
                            //   userInput.text = value.toString();
                            // });
                          },

                          decoration: InputDecoration(
                            //contentPadding: EdgeInsets.only(top: 15,bottom: 15),

                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            focusColor: Colors.white,
                            //add prefix icon

                            // errorText: "Error",

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: darkGreyTextColor1, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: Colors.grey,
                            hintText: "",

                            //make hint text
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: "verdana_regular",
                              fontWeight: FontWeight.w400,
                            ),

                            //create lable
                            labelText: 'Glass Width',
                            labelStyle: TextStyle(
                              color: darkRedColor,
                              fontSize: 16,
                              fontFamily: "verdana_regular",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height*0.02,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16,right: 16,top: 0),
                        child: TextFormField(
                          autofocus: true,
                          controller: _glassTypeControoler,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,

                          ),
                          onChanged: (value) {
                            // setState(() {
                            //   userInput.text = value.toString();
                            // });
                          },
                          decoration: InputDecoration(
                            //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                            focusColor: Colors.white,
                            //add prefix icon
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

                            // errorText: "Error",

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: darkGreyTextColor1, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: Colors.grey,
                            hintText: "",


                            //make hint text
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: "verdana_regular",
                              fontWeight: FontWeight.w400,
                            ),

                            //create lable
                            labelText: 'Glass Type',
                            //lable style
                            labelStyle: TextStyle(
                              color: darkRedColor,
                              fontSize: 16,
                              fontFamily: "verdana_regular",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height*0.02,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16,right: 16,top: 0),
                        child: TextFormField(
                          autofocus: true,
                          controller: _quantityControoler,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,

                          ),
                          onChanged: (value) {
                            // setState(() {
                            //   userInput.text = value.toString();
                            // });
                          },
                          decoration: InputDecoration(
                            //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                            focusColor: Colors.white,
                            //add prefix icon
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

                            // errorText: "Error",

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: darkGreyTextColor1, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: Colors.grey,
                            hintText: "",
                            //make hint text
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: "verdana_regular",
                              fontWeight: FontWeight.w400,
                            ),
                            //create lable
                            labelText: 'Quantity',
                            //lable style
                            labelStyle: TextStyle(
                              color: darkRedColor,
                              fontSize: 16,
                              fontFamily: "verdana_regular",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height*0.02,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16,right: 16,top: 0),
                        child: TextFormField(
                          autofocus: true,
                          controller: _addressControoler,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,

                          ),
                          onChanged: (value) {
                            // setState(() {
                            //   userInput.text = value.toString();
                            // });
                          },
                          decoration: InputDecoration(
                            //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                            focusColor: Colors.white,
                            //add prefix icon
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

                            // errorText: "Error",

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: darkGreyTextColor1, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: Colors.grey,
                            hintText: "",


                            //make hint text
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: "verdana_regular",
                              fontWeight: FontWeight.w400,
                            ),

                            //create lable
                            labelText: 'Delivery Address',
                            //lable style
                            labelStyle: TextStyle(
                              color: darkRedColor,
                              fontSize: 16,
                              fontFamily: "verdana_regular",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: size.height*0.05,
                      ),
                      _isLoading ? CircularProgressIndicator(
                        color: primaryColor,
                        strokeWidth: 2
                        ,
                      ) :
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: Container(

                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                              colors: [
                                darkRedColor,
                                lightRedColor,

                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all(Size(size.width, 50)),
                                backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                                // elevation: MaterialStateProperty.all(3),
                                shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                              ),

                              onPressed: () async {
                                print(email.toString() + ' uid');
                                print(name.toString());
                                print(uid.toString());
                               setState(() {
                                 _productsListForPost.clear();
                                 _productsListForPost.add({
                                   "productName": _titleControoler.text.toString(),
                                   "productImage": "https://cdn.iconscout.com/icon/free/png-256/free-order-management-market-store-cart-trolley-shopping-2-5273.png?f=webp",
                                   "productCode": _glassTypeControoler.text.toString(),
                                   "productPrice": "",
                                   "category": _glassHeightControoler.text.toString(),
                                   "productStatus": _glassWidthControoler.text.toString(),
                                   "productQuantity": _quantityControoler.text.toString(),
                                   "userId":  uid,
                                   "userName":  name,
                                   "userType": "Custom Order",
                                   "userEmail":  email,
                                 });
                               });


                                if(_titleControoler.text.isEmpty) {

                                  Fluttertoast.showToast(
                                    msg: "Enter title",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 4,
                                  );

                                } else if(_glassHeightControoler.text.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "Enter glass height",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 4,
                                  );
                                } else if(_glassWidthControoler.text.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "Enter glass width",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 4,
                                  );
                                } else if(_glassTypeControoler.text.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "Enter glass type",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 4,
                                  );
                                } else if(_quantityControoler.text.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "Enter quantity of glass",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 4,
                                  );
                                } else if(_addressControoler.text.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "Enter delivery address",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 4,
                                  );
                                }

                                else {

                                  setState(() {
                                    _isLoading = true;
                                  });

                                  FirebaseFirestore.instance
                                      .collection('Orders')
                                      .doc()
                                      .set({
                                    "orderId": Random().nextInt(100000000).toString(),
                                    "recipientName": name,
                                    "recipientEmail": email,
                                    "recipientUid": uid,
                                    "userType": "Custom Order",
                                    "deliveryAddress": _addressControoler.text,
                                    "orderStatus": "Pending",
                                    "orderTotal": "Custom Order",
                                    "paymentMethod": 'Cash on Delivery',
                                    "paymentPaid": 'no',
                                    "orderTotalItems": _quantityControoler.text.toString(),
                                     "items": _productsListForPost,

                                  }).then((value) {

                                    setState(() {
                                      _isLoading = false;
                                    });
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (c, a1, a2) => AppBottomNavBarScreen(index: 0, title: userType, subTitle: '',),
                                        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                        transitionDuration: Duration(milliseconds: 100),
                                      ),
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                        backgroundColor: Colors.blue,
                                        content: Text(
                                          'Order Placed successfully',
                                          style:
                                          TextStyle(color: whiteColor),
                                        )));


                                  });

                                }





                              }, child: Text('Place Custom Order', style: buttonStyle)),
                        ),
                      ),
                      SizedBox(
                        height: size.height*0.1,
                      ),
                    ],
                  ),
                ),

              ),




              // Center(
              //   child: SizedBox(
              //     height: 120,
              //     width: 120,
              //     child: Image.asset('assets/images/logo_trans.png', fit: BoxFit.scaleDown,
              //       height: 120,
              //       width: 120,),
              //   ),
              // ),

              // Container(
              //   width: size.width,
              //   height: size.height,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //
              //
              //
              //       Container(
              //
              //         decoration: BoxDecoration(
              //           boxShadow: [
              //             BoxShadow(
              //                 color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
              //           ],
              //           gradient: LinearGradient(
              //             begin: Alignment.topLeft,
              //             end: Alignment.bottomRight,
              //             stops: [0.0, 1.0],
              //             colors: [
              //               lightRedColor,
              //               darkRedColor,
              //             ],
              //           ),
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         child: ElevatedButton(
              //             style: ButtonStyle(
              //               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //                 RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(10.0),
              //                 ),
              //               ),
              //               minimumSize: MaterialStateProperty.all(Size(size.width*0.8, 50)),
              //               backgroundColor:
              //               MaterialStateProperty.all(Colors.transparent),
              //               // elevation: MaterialStateProperty.all(3),
              //               shadowColor:
              //               MaterialStateProperty.all(Colors.transparent),
              //             ),
              //
              //             onPressed: (){}, child: Text('Login', style: buttonStyle)),
              //       ),
              //
              //       SizedBox(
              //         height: size.height*0.05,
              //       ),
              //
              //       Center(
              //         child: SizedBox(
              //           height: 10,
              //           width: 100,
              //           child: Image.asset('assets/images/red_line.png', fit: BoxFit.scaleDown,
              //             height: 10,
              //             width: 100,),
              //         ),
              //       ),
              //       SizedBox(
              //         height: size.height*0.025,
              //       ),
              //     ],
              //   ),
              // ),

            ],),
        ),
      ),
    );
  }

  // showAlertDialog(BuildContext context, String title, String content) {
  //   // set up the button
  //
  //   CupertinoAlertDialog alert = CupertinoAlertDialog(
  //     title: Text("$title"),
  //     content: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Text("$content"),
  //     ),
  //     actions: [
  //       // CupertinoDialogAction(
  //       //     child: Text("YES"),
  //       //     onPressed: ()
  //       //     {
  //       //       Navigator.of(context).pop();
  //       //     }
  //       // ),
  //       CupertinoDialogAction(
  //           child: Text("OK"),
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           })
  //     ],
  //   );
  //
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

}
