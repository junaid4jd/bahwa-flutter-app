

import 'package:bahwa_flutter_app/constants.dart';
import 'package:bahwa_flutter_app/res/app_assets.dart';
import 'package:bahwa_flutter_app/res/colors.dart';
import 'package:bahwa_flutter_app/res/components/back_button.dart';
import 'package:bahwa_flutter_app/utils/routes/routes_name.dart';
import 'package:bahwa_flutter_app/view/bottomNavBar/app_bottom_nav_bar_admin.dart';
import 'package:bahwa_flutter_app/view/bottomNavBar/app_bottom_nav_bar_screen.dart';
import 'package:bahwa_flutter_app/view_model/firebase_auth.dart';
import 'package:bahwa_flutter_app/view_model/input_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  final String userType;
  const LoginScreen({Key? key, required this.userType}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordControoler = TextEditingController();
  final TextEditingController _emailControoler = TextEditingController();
  bool _isLoading = false;
  bool _isVisible = false;
  MethodsHandler _methodsHandler = MethodsHandler();
  InputValidator _inputValidator = InputValidator();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String isCreated = '';
  String isCreatedStudent = '';

  @override
  void initState() {
    print('Admin ${widget.userType}');
    // TODO: implement initState
    // if( widget.userType == 'Admin') {
    //
    //   setState(() {
    //     _emailControoler.text = 'admin@gmail.com';
    //     _passwordControoler.text = '12345678';
    //   });
    //
    // }
    // else {
    //   setState(() {
    //     _emailControoler.text = 'alirahman@gmail.com';
    //     _passwordControoler.text = '12345678';
    //   });
    // }
    setState(() {



      isCreated = '';
      isCreatedStudent = '';
      _isVisible = false;
      _isLoading = false;
    });
    print('userType');
    print(widget.userType.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // return  final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(0),
                        topLeft: Radius.circular(0)
                    )
                ),
                child: Column(
                  children: [

                    SizedBox(
                      height: size.height*0.025,
                    ),
                    AppBackButton(route: widget.userType == 'Admin'  ? RoutesName.userType : RoutesName.welcome,),

                    SizedBox(
                      height: size.height*0.1,
                    ),

                    Center(
                      child: SizedBox(
                        height: 100,
                        width: 200,
                        child: Image.asset(AppAssets.logo, fit: BoxFit.scaleDown,
                          height: 100,
                          width: 200,),
                      ),
                    ),

                    SizedBox(
                      height: size.height*0.03,
                    ),

                    Center(
                        child: Text('Welcome Back', style: TextStyle(color: Color(0xFF585858), fontSize: 16,fontWeight: FontWeight.bold),)
                    ),

                    SizedBox(
                      height: size.height*0.05,
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                      child: TextFormField(
                        controller: _emailControoler,
                        keyboardType: TextInputType.emailAddress,
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
                          labelText: 'Email Address',
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
                        obscureText: _isVisible ? false : true,
                        controller: _passwordControoler,

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

                          suffixIcon: IconButton(
                            icon: Icon(
                              _isVisible
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey,
                              size: 23,
                            ),
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                              print(_isVisible);
                            },
                          ),

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
                          labelText: 'Password',
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
                    widget.userType.toString() != 'Admin' ?
                    Container(
                      width: size.width * 0.85,
                      margin: const EdgeInsets.only(top: 0),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   PageRouteBuilder(
                          //     pageBuilder: (c, a1, a2) => AppBottomNavBarScreen(index: 0, title: '', subTitle: '',),
                          //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                          //     transitionDuration: Duration(milliseconds: 100),
                          //   ),
                          // );
                        },
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ) : Container(),

                    SizedBox(
                      height: size.height * 0.03,
                    ),

                    _isLoading
                        ? CircularProgressIndicator(
                      color: primaryColor,
                      strokeWidth: 2,
                    )
                        :
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


                              if (_inputValidator
                                  .validateEmail(_emailControoler.text) !=
                                  'success' &&
                                  _emailControoler.text.isNotEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const  SnackBar(
                                        content:  Text('Wrong email, please use a correct email')
                                    )
                                );
                              }

                              else {
                                if (_emailControoler.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const  SnackBar(
                                          content:  Text('Enter Email Address')
                                      )
                                  );
                                } else if (_passwordControoler.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const  SnackBar(
                                          content:  Text('Enter Password')
                                      )
                                  );
                                }
                                else {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                                  try {
                                    if (widget.userType == 'Users') {
                                      final snapshot = await FirebaseFirestore.instance.collection('Users').get();
                                      snapshot.docs.forEach((element) {
                                        print('user data');
                                        if(element['email'] == _emailControoler.text.toString().trim()) {
                                          print('user age in if of current user ');
                                          //   print(element['age']);
                                          setState(() {
                                            isCreated = 'yes';
                                          });
                                        }
                                      });

                                      if(isCreated == 'yes') {
                                        final result =
                                        await _auth.signInWithEmailAndPassword(
                                            email: _emailControoler.text
                                                .trim()
                                                .toString(),
                                            password: _passwordControoler.text);
                                        final user = result.user;

                                        prefs.setString(
                                            'userEmail', _emailControoler.text);
                                        prefs.setString(
                                            'userPassword', _passwordControoler.text);
                                        prefs.setString('userId', user!.uid);
                                        prefs.setString('userType', widget.userType.toString());
                                        print('Account creation successful');
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (c, a1, a2) => AppBottomNavBarScreen(index: 0, title: widget.userType.toString(), subTitle: '',),
                                            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                            transitionDuration: Duration(milliseconds: 100),
                                          ),
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const  SnackBar(
                                                content:  Text('Successfully Login')
                                            )
                                        );
                                      }
                                      else {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        _methodsHandler.showAlertDialog(
                                            context, 'Sorry', 'User Not Found');
                                      }
                                    }
                                    else if (widget.userType == 'Farmer') {
                                      final snapshot = await FirebaseFirestore.instance.collection('Farmer').get();
                                      snapshot.docs.forEach((element) {
                                        print('user data');
                                        if(element['email'] == _emailControoler.text.toString().trim()) {
                                          print('user age in if of current user ');
                                          //   print(element['age']);
                                          setState(() {
                                            isCreated = 'yes';
                                          });
                                        }
                                      });

                                      if(isCreated == 'yes') {
                                        final result =
                                        await _auth.signInWithEmailAndPassword(
                                            email: _emailControoler.text
                                                .trim()
                                                .toString(),
                                            password: _passwordControoler.text);
                                        final user = result.user;

                                        prefs.setString(
                                            'userEmail', _emailControoler.text);
                                        prefs.setString(
                                            'userPassword', _passwordControoler.text);
                                        prefs.setString('userId', user!.uid);
                                        prefs.setString('userType', widget.userType.toString());
                                        print('Account creation successful');
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        // Navigator.pushReplacement(
                                        //   context,
                                        //   PageRouteBuilder(
                                        //     pageBuilder: (c, a1, a2) => AppBottomNavBarScreen(index: 0, title: widget.userType.toString(), subTitle: '',),
                                        //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                        //     transitionDuration: Duration(milliseconds: 100),
                                        //   ),
                                        // );
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const  SnackBar(
                                                content:  Text('Successfully Login')
                                            )
                                        );
                                      }
                                      else {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        _methodsHandler.showAlertDialog(
                                            context, 'Sorry', 'User Not Found');
                                      }
                                    }
                                    else {
                                      if (widget.userType == 'Admin' && _emailControoler.text == 'admin@gmail.com' && _passwordControoler.text == '12345678') {

                                        prefs.setString(
                                            'userEmail', _emailControoler.text);
                                        prefs.setString(
                                            'userPassword', _passwordControoler.text);
                                        print(widget.userType.toString());
                                        prefs.setString('userType', widget.userType.toString());
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (c, a1, a2) => AppBottomNavBarAdminScreen(index: 0, title: widget.userType.toString(), subTitle: '',),
                                            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                            transitionDuration: Duration(milliseconds: 100),
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        _methodsHandler.showAlertDialog(
                                            context, 'Sorry', 'User Not Found');
                                      }


                                    }


                                  }
                                  on FirebaseAuthException catch (e)
                                  {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    print(e.code);
                                    switch (e.code) {
                                      case 'invalid-email':
                                        _methodsHandler.showAlertDialog(context,
                                            'Sorry', 'Invalid Email Address');

                                        setState(() {
                                          _isLoading = false;
                                        });
                                        break;
                                      case 'wrong-password':
                                        _methodsHandler.showAlertDialog(
                                            context, 'Sorry', 'Wrong Password');
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        break;
                                      case 'user-not-found':
                                        _methodsHandler.showAlertDialog(
                                            context, 'Sorry', 'User Not Found');
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        break;
                                      case 'user-disabled':
                                        _methodsHandler.showAlertDialog(
                                            context, 'Sorry', 'User Disabled');
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        break;
                                    }
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }

                                }
                              }


                            }, child: Text('Login', style: buttonStyle)),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.1,
                    ),

                  ],
                ),

              ),


            ],),
        ),
      ),
    );

  }
}

// import 'package:bahwa_flutter_app/constants.dart';
// import 'package:bahwa_flutter_app/res/round_button.dart';
// import 'package:bahwa_flutter_app/utils/utils.dart';
// import 'package:flutter/material.dart';
//
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailAddressController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   //final cartController = Get.put(AddToCartController());
//   String userId = '', userName = '', userEmail = '';
//   bool isLoading = false;
//
//   ValueNotifier obsecurePassword = ValueNotifier(true);
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     setState(() {
//       userEmail = '';
//     });
//
//     setState(() {
//       //  _phoneController.text = widget.phone.toString();
//       isLoading = false;
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//
//     _emailAddressController.dispose();
//     _passwordController.dispose();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final height = MediaQuery.of(context).size.height*1;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       //resizeToAvoidBottomInset: false,
//       body: Container(
//         width: size.width,
//         height: size.height,
//         decoration: new BoxDecoration(
//           color: Colors.white,
//         ),
//         child: Stack(
//           alignment: Alignment.bottomCenter,
//           children: [
//             Column(
//               children: [
//                 Center(
//                   child: SizedBox(
//                     height: size.height * 0.35,
//                     width: size.width,
//                     child: Image.asset(
//                       'assets/images/sign_in_bg.png',
//                       fit: BoxFit.cover,
//                       height: size.height * 0.35,
//                       width: size.width,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SingleChildScrollView(
//               child: Container(
//                 height: size.height,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Container(
//                       height: size.height * 0.7,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(30),
//                               topLeft: Radius.circular(30))),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: size.height * 0.05,
//                           ),
//                           Center(
//                             child: SizedBox(
//                               height: 80,
//                               width: 120,
//                               child: Image.asset(
//                                 'assets/images/welcome_logo.png',
//                                 fit: BoxFit.scaleDown,
//                                 height: 80,
//                                 width: 120,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: size.height * 0.03,
//                           ),
//                           Center(
//                               child: Text(
//                             'Welcome back $userName!',
//                             style: TextStyle(
//                                 color: Color(0xFF585858),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold),
//                           )),
//                           SizedBox(
//                             height: size.height * 0.05,
//                           ),
//                           Container(
//                             margin:
//                                 EdgeInsets.only(left: 16, right: 16, bottom: 0),
//                             child: TextFormField(
//                               controller: _emailAddressController,
//                               keyboardType: TextInputType.emailAddress,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black,
//                               ),
//                               onChanged: (value) {
//                                 // setState(() {
//                                 //   userInput.text = value.toString();
//                                 // });
//                               },
//                               decoration: InputDecoration(
//                                 //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
//                                 contentPadding:
//                                     EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                 focusColor: Colors.white,
//                                 //add prefix icon
//
//                                 // errorText: "Error",
//
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: darkGreyTextColor1, width: 1.0),
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//                                 fillColor: Colors.grey,
//                                 hintText: "",
//
//                                 //make hint text
//                                 hintStyle: TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 16,
//                                   fontFamily: "verdana_regular",
//                                   fontWeight: FontWeight.w400,
//                                 ),
//
//                                 //create lable
//                                 labelText: 'Email Address',
//                                 //lable style
//                                 labelStyle: TextStyle(
//                                   color: darkRedColor,
//                                   fontSize: 16,
//                                   fontFamily: "verdana_regular",
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: size.height * 0.02,
//                           ),
//                           ValueListenableBuilder(
//                               valueListenable: obsecurePassword,
//                               builder: (context, value, child) {
//                                 return Container(
//                                   margin: EdgeInsets.only(
//                                       left: 16, right: 16, top: 0),
//                                   child: TextFormField(
//                                     autofocus: true,
//                                     controller: _passwordController,
//                                     obscureText: true,
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.black,
//                                     ),
//                                     onChanged: (value) {
//                                       // setState(() {
//                                       //   userInput.text = value.toString();
//                                       // });
//                                     },
//                                     decoration: InputDecoration(
//                                       //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
//                                       focusColor: Colors.white,
//
//                                       suffixIcon:
//                                           GestureDetector(
//                                               onTap: () {
//                                                 obsecurePassword.value = !obsecurePassword.value;
//                                               },
//                                               child: Icon(
//                                                   obsecurePassword.value ? Icons.visibility_off_outlined :
//
//                                                   Icons.visibility)),
//
//                                       //add prefix icon
//                                       contentPadding: EdgeInsets.fromLTRB(
//                                           20.0, 15.0, 20.0, 15.0),
//
//                                       // errorText: "Error",
//
//                                       border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0),
//                                       ),
//
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: const BorderSide(
//                                             color: darkGreyTextColor1,
//                                             width: 1.0),
//                                         borderRadius:
//                                             BorderRadius.circular(10.0),
//                                       ),
//                                       fillColor: Colors.grey,
//                                       hintText: "",
//
//                                       //make hint text
//                                       hintStyle: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//
//                                       //create lable
//                                       labelText: 'Password',
//                                       //lable style
//                                       labelStyle: TextStyle(
//                                         color: darkRedColor,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }),
//                           SizedBox(
//                             height: size.height * 0.02,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 16, right: 16),
//                             child: GestureDetector(
//                               onTap: () {},
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     'Forget Password?',
//                                     style: TextStyle(
//                                         color: Color(0xFF585858),
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: size.height * 0.05,
//                           ),
//                          RoundButton(title: 'Login', onPress: () {
//
//                            if(_emailAddressController.text.isEmpty) {
//                              Utils.toastMessage('Enter email ');
//                            } else if (_passwordController.text.isEmpty) {
//                              Utils.toastMessage('Enter password ');
//
//                            } else if (_passwordController.text.length < 6) {
//                              Utils.toastMessage('Please enter 6 digits password ');
//
//
//                            } else {
//                              print('Hit api');
//
//                            }
//
//                          }, ),
//
//
//                           // Padding(
//                           //         padding: const EdgeInsets.only(
//                           //             left: 16, right: 16),
//                           //         child: Container(
//                           //           decoration: BoxDecoration(
//                           //             boxShadow: [
//                           //               BoxShadow(
//                           //                   color: Colors.black26,
//                           //                   offset: Offset(0, 4),
//                           //                   blurRadius: 5.0)
//                           //             ],
//                           //             gradient: LinearGradient(
//                           //               begin: Alignment.topLeft,
//                           //               end: Alignment.bottomRight,
//                           //               stops: [0.0, 1.0],
//                           //               colors: [
//                           //                 darkRedColor,
//                           //                 lightRedColor,
//                           //               ],
//                           //             ),
//                           //             borderRadius: BorderRadius.circular(10),
//                           //           ),
//                           //           child: ElevatedButton(
//                           //               style: ButtonStyle(
//                           //                 shape: MaterialStateProperty.all<
//                           //                     RoundedRectangleBorder>(
//                           //                   RoundedRectangleBorder(
//                           //                     borderRadius:
//                           //                         BorderRadius.circular(10.0),
//                           //                   ),
//                           //                 ),
//                           //                 minimumSize:
//                           //                     MaterialStateProperty.all(
//                           //                         Size(size.width, 50)),
//                           //                 backgroundColor:
//                           //                     MaterialStateProperty.all(
//                           //                         Colors.transparent),
//                           //                 // elevation: MaterialStateProperty.all(3),
//                           //                 shadowColor:
//                           //                     MaterialStateProperty.all(
//                           //                         Colors.transparent),
//                           //               ),
//                           //               onPressed: () {},
//                           //               child: Text(
//                           //                 'Login',
//                           //                 style: TextStyle(color: Colors.white),
//                           //               )),
//                           //         ),
//                           //       ),
//                           SizedBox(
//                             height: size.height * 0.05,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     body: Column(children: [
//   //
//   //       GestureDetector(
//   //           onTap: (){
//   //
//   //             Utils.toastMessage('No internet connection');
//   //             Navigator.pushNamed(context, RoutesName.home);
//   //           },
//   //           child: Text('Click'))
//   //
//   //     ],),
//   //   );
//   // }
// }
