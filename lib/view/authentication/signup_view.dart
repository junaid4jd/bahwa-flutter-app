


import 'package:bahwa_flutter_app/constants.dart';
import 'package:bahwa_flutter_app/res/app_assets.dart';
import 'package:bahwa_flutter_app/res/colors.dart';
import 'package:bahwa_flutter_app/utils/routes/routes_name.dart';
import 'package:bahwa_flutter_app/view/authentication/login_view.dart';
import 'package:bahwa_flutter_app/view_model/firebase_auth.dart';
import 'package:bahwa_flutter_app/view_model/input_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  final String userType;
  const SignUpScreen({Key? key, required this.userType,
  }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _fullNameControoler = TextEditingController();
  final TextEditingController _firstNameControoler = TextEditingController();
  final TextEditingController _lastNameControoler = TextEditingController();
  final TextEditingController _emailControoler = TextEditingController();
  final TextEditingController _phoneControoler = TextEditingController();
  final TextEditingController _addressControoler = TextEditingController();
  final TextEditingController _passwordControoler = TextEditingController();
  final TextEditingController _confirmPasswordControoler = TextEditingController();


  MethodsHandler _methodsHandler = MethodsHandler();
  InputValidator _inputValidator = InputValidator();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    super.initState();
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

                      SizedBox(
                        height: size.height*0.03,
                      ),
                      GestureDetector(
                        onTap:() {
                          print('tapping to remove');
                          Navigator.pushNamed(context, RoutesName.welcome, arguments: widget.userType);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: size.width*0.95,
                            child: IconButton(onPressed: () {
                              print('tapping to remove');
                              Navigator.pushNamed(context, RoutesName.welcome, arguments: widget.userType);

                            }, icon: Icon(Icons.arrow_back, color: AppColors.darkRedColor,size: 20,)),

                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height*0.03,
                      ),

                      Center(
                        child: SizedBox(
                          height: 100,
                          width: size.width*0.8,
                          child: Image.asset(AppAssets.logo, fit: BoxFit.scaleDown,
                            height: 100,
                            width: size.width*0.8,),
                        ),
                      ),

                      SizedBox(
                        height: size.height*0.03,
                      ),

                      Center(
                          child: Text('Create Account', style: TextStyle(color: Color(0xFF585858), fontSize: 16,fontWeight: FontWeight.bold),)
                      ),

                      SizedBox(
                        height: size.height*0.05,
                      ),


                      Container(
                        margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                        child: TextFormField(
                          controller: _firstNameControoler,
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
                            labelText: 'Full Name',
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
                        margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                        child: TextFormField(
                          controller: _phoneControoler,
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
                            labelText: 'Phone Number',
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
                      Container(
                        margin: EdgeInsets.only(left: 16,right: 16,top: 0),
                        child: TextFormField(
                          autofocus: true,
                          controller: _confirmPasswordControoler,
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

                                if (_inputValidator.validateName(
                                    _firstNameControoler.text) !=
                                    'success' &&
                                    _firstNameControoler.text.isNotEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Invalid User Name",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }
                                else if (_inputValidator.validateEmail(
                                    _emailControoler.text) !=
                                    'success' &&
                                    _emailControoler.text.isNotEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Wrong email address",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }

                                else if ((_passwordControoler.text.length <
                                    7 &&
                                    _passwordControoler
                                        .text.isNotEmpty) &&
                                    (_confirmPasswordControoler.text.length < 7 &&
                                        _confirmPasswordControoler
                                            .text.isNotEmpty)) {
                                  Fluttertoast.showToast(
                                      msg: "Password and Confirm Password must be same",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );

                                }
                                else if (_passwordControoler.text !=
                                    _confirmPasswordControoler.text) {
                                  Fluttertoast.showToast(
                                      msg: "Password and Confirm Password must be same",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }
                                else {
                                  if(_firstNameControoler.text.isEmpty)
                                  {
                                    Fluttertoast.showToast(
                                        msg: "First Name is required",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }
                                  else if(_emailControoler.text.isEmpty)
                                  {
                                    Fluttertoast.showToast(
                                        msg: "Email Address is required",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }

                                  else if(_passwordControoler.text.isEmpty)
                                  {
                                    Fluttertoast.showToast(
                                        msg: "Password is required",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }
                                  else if(_confirmPasswordControoler.text.isEmpty)
                                  {
                                    Fluttertoast.showToast(
                                        msg: "Confirm Password is required",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }
                                  else {
                                    setState(() {
                                      _isLoading = true;
                                      print('We are in loading');
                                      //  state = ButtonState.loading;
                                    });

                                    print(_firstNameControoler.text.toString());
                                    print( _emailControoler.text.toString());
                                    print( _addressControoler.text.toString());
                                    print( _passwordControoler.text.toString());
                                    print( _phoneControoler.text.toString());
                                    //createAccount();
                                    //_methodsHandler.createAccount(name: _controllerClinic.text, email: _controller.text, password: _controllerPass.text, context: context);
                                    SharedPreferences prefs = await SharedPreferences.getInstance();

                                    FirebaseFirestore.instance
                                        .collection(widget.userType.toString()).where(
                                        "email",isEqualTo: _emailControoler.text.trim()).get().then((value) async {


                                      if(value.docs.isNotEmpty) {
                                        setState(() {
                                          _isLoading = false;
                                        });

                                        Fluttertoast.showToast(
                                          msg: "Sorry email account already exists",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 4,
                                        );
                                      }
                                      else {
                                        try {
                                          User? result = (await _auth
                                              .createUserWithEmailAndPassword(
                                              email:
                                              _emailControoler.text.trim(),
                                              password: _passwordControoler.text
                                                  .trim()))
                                              .user;

                                          if(result != null) {

                                            var user = result;

                                            FirebaseFirestore.instance
                                                .collection(widget.userType.toString())
                                                .doc()
                                                .set({
                                              "email": _emailControoler.text.trim(),
                                              "password": _passwordControoler.text.trim(),
                                              "uid": user.uid,
                                              "name": _firstNameControoler.text,
                                              "userType": widget.userType.toString(),

                                            }).then((value) => print('success'));




                                            prefs.setString('userEmail',
                                                _emailControoler.text.trim());
                                            prefs.setString('userPassword',
                                                _passwordControoler.text.trim());
                                            prefs.setString('name',
                                                _firstNameControoler.text.trim());
                                            prefs.setString('userId', user.uid);
                                            print('Account creation successful');
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            Navigator.pushReplacement(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (c, a1, a2) => LoginScreen(userType: widget.userType,),
                                                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                                transitionDuration: Duration(milliseconds: 100),
                                              ),
                                            );
                                            Fluttertoast.showToast(
                                              msg: "Account created successfully",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 4,
                                            );


                                          }
                                          else {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            print('error');
                                          }

                                        }
                                        on FirebaseAuthException catch (e) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          if(e.code == 'email-already-in-use') {

                                            showAlertDialog(context, 'Sorry', 'The email address is already in use by another account.');
                                          }
                                          print(e.message);
                                          print(e.code);
                                        }

                                        await Future.delayed(Duration(seconds: 1));

                                      }

                                    });



                                  }
                                }



                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) =>  DashBoardScreen(index: 0, title: '',)),
                                // );
                              }, child: Text('Sign Up', style: buttonStyle)),
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
  showAlertDialog(BuildContext context, String title, String content) {
    // set up the button

    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text("$title"),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("$content"),
      ),
      actions: [
        // CupertinoDialogAction(
        //     child: Text("YES"),
        //     onPressed: ()
        //     {
        //       Navigator.of(context).pop();
        //     }
        // ),
        CupertinoDialogAction(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            })
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
