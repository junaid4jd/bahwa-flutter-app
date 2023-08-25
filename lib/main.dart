import 'dart:io';

import 'package:bahwa_flutter_app/utils/routes/routes.dart';
import 'package:bahwa_flutter_app/utils/routes/routes_name.dart';
import 'package:bahwa_flutter_app/view/bottomNavBar/app_bottom_nav_bar_admin.dart';
import 'package:bahwa_flutter_app/view/bottomNavBar/app_bottom_nav_bar_screen.dart';
import 'package:bahwa_flutter_app/view/splash/splash_screen.dart';
import 'package:bahwa_flutter_app/view_model/getx_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.length == 0) {
    await Firebase.initializeApp();


  }


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final cartController = Get.put(AddToCartController());
  String userType = '',email = '', uid = '';



  getData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Starting usertype ' + prefs.getString('userType').toString());
    if(prefs.getString('userType') != null) {
      setState(() {
        userType = prefs.getString('userType')!;
        email = prefs.getString('userEmail')!;
        // uid = prefs.getString('userId')!;
      });
      print(userType.toString() + ' This is user type');
    } else {
      print('Starting usertype');
    }

    if(userType != 'Admin') {
      cartController.fetchCartItems();
    }

  }
  @override
  void initState() {
    print('Starting usertype');

    // TODO: implement initState
    // setState(() {
    //   userType = '';
    //   email = '';
    //   uid = '';
    // });

    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      onGenerateRoute:Routes.generateRoutes,
      initialRoute: RoutesName.splash,
      theme: ThemeData(fontFamily: 'Poppins'),
      home:
      userType == 'Users' || email != 'null' ? AppBottomNavBarScreen(index: 0, title: userType, subTitle: uid,) :
      userType == 'Admin' ? AppBottomNavBarAdminScreen(index: 0, title: userType, subTitle: uid,) :
      SplashScreen(),
    );
  }
}
