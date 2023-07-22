import 'dart:async';

import 'package:bahwa_flutter_app/constants.dart';
import 'package:bahwa_flutter_app/res/app_assets.dart';
import 'package:bahwa_flutter_app/view/authentication/usertype_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:mec/constants.dart';



class SplashScreen extends StatefulWidget {
  //final Color backgroundColor = Colors.white;
  //final NotificationAppLaunchDetails? notificationAppLaunchDetails;
  const SplashScreen({Key? key, }) : super(key: key);


  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 1; // delay for 5 seconds

  @override
  void initState() {
    super.initState();
   _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => UserType()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 120,
                width: size.width*0.8,
                child: Image.asset(AppAssets.logo, fit: BoxFit.scaleDown,)),
          ],
        ),
      ),
    );
  }
}
