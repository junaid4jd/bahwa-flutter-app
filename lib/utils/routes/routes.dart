import 'package:bahwa_flutter_app/utils/routes/routes_name.dart';
import 'package:bahwa_flutter_app/view/authentication/login_view.dart';
import 'package:bahwa_flutter_app/view/authentication/usertype_view.dart';
import 'package:bahwa_flutter_app/view/bottomNavBar/app_bottom_nav_bar_screen.dart';
import 'package:bahwa_flutter_app/view/order/place_custom_order.dart';
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
       return MaterialPageRoute(builder: (BuildContext context)  => AppBottomNavBarScreen(index: 0, title: '', subTitle: '',));
     case RoutesName.login:
       return MaterialPageRoute(builder: (BuildContext context)  =>  LoginScreen(userType: settings.arguments.toString(),));
     case RoutesName.welcome:
       return MaterialPageRoute(builder: (BuildContext context)  =>  WelcomeScreen(userType: settings.arguments.toString(),));
     case RoutesName.placeCustomOrder:
       return MaterialPageRoute(builder: (BuildContext context)  =>  PlaceCustomOrder());
     default:
       return MaterialPageRoute(builder: (BuildContext context)  =>  Center(child: Text('No Route Defined'),));
   }

  }

}