import 'package:bahwa_flutter_app/utils/routes/routes_name.dart';
import 'package:bahwa_flutter_app/view/authentication/login_view.dart';
import 'package:bahwa_flutter_app/view/authentication/usertype_view.dart';
import 'package:bahwa_flutter_app/view/splash/splash_screen.dart';
import 'package:bahwa_flutter_app/view/welcome/welcome_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../view/home/home_screen.dart';


class Routes {

 static Route<dynamic> generateRoutes(RouteSettings settings) {

   switch(settings.name) {
     case RoutesName.splash:
       return MaterialPageRoute(builder: (BuildContext context)  => const SplashScreen());
     case RoutesName.userType:
       return MaterialPageRoute(builder: (BuildContext context)  =>  UserType());
     case RoutesName.home:
       return MaterialPageRoute(builder: (BuildContext context)  => const MyHomePage(title: ''));
     case RoutesName.login:
       return MaterialPageRoute(builder: (BuildContext context)  =>  LoginScreen(userType: settings.arguments.toString(),));
     case RoutesName.welcome:
       return MaterialPageRoute(builder: (BuildContext context)  =>  WelcomeScreen(userType: settings.arguments.toString(),));

     default:
       return MaterialPageRoute(builder: (BuildContext context)  =>  Center(child: Text('No Route Defined'),));
   }

  }

}