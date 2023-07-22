
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {

 static  toastMessage(String message) {

    Fluttertoast.showToast(msg: message);

  }


  // static void flushBarErrorMessage(String message, BuildContext context) {
  //  showFlushbar(context: context, flushbar: Flushbar(
  //    message: message.toString(),
  //    backgroundColor: Colors.red,
  //    title: 'Error',
  //    titleColor: Colors.white,
  //    duration: Duration(seconds: 3),
  //  )..show(context)
  //  );
  // }

}