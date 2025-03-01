import 'package:flutter/material.dart';
import 'package:task/app/routing/routing.dart';
import 'package:task/presentaion/create_branch/create_brach_view.dart';
import 'package:task/presentaion/splash/splash_view.dart';
import 'package:task/presentaion/home.dart';

class AppRoutes {
  Route? generateRoute(RouteSettings screen) {
    switch (screen.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (context) => Home());
      case Routes.createBranch:
        return MaterialPageRoute(builder: (context) => CreateBranch());
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      default:
        return null;
    }
  }
}
