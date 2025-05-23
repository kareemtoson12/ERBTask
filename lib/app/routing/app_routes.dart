import 'package:flutter/material.dart';
import 'package:task/app/routing/routing.dart';
import 'package:task/presentaion/createQrCode/craete_qr_code.dart';
import 'package:task/presentaion/create_branch/create_brach_view.dart';
import 'package:task/presentaion/create_sku.dart/create_sku_view.dart';
import 'package:task/presentaion/search_sku/search_sku_view.dart';
import 'package:task/presentaion/skuDeactivation/sku_deactivation_view.dart';
import 'package:task/presentaion/splash/splash_view.dart';
import 'package:task/presentaion/home/home.dart';

class AppRoutes {
  Route? generateRoute(RouteSettings screen) {
    switch (screen.name) {
      /*    case Routes.home:
        return MaterialPageRoute(builder: (context) => Home()); */
      case Routes.createBranch:
        return MaterialPageRoute(builder: (context) => CreateBranch());
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case Routes.createSku:
        return MaterialPageRoute(builder: (context) => SkuCreationScreen());
      case Routes.searchSku:
        return MaterialPageRoute(builder: (context) => SearchSkuScreen());
      case Routes.deactiveSku:
        return MaterialPageRoute(builder: (context) => SkuDeactivationScreen());
      case Routes.qrCodeScreen:
        return MaterialPageRoute(builder: (context) => QrBarcodeScreen());

      default:
        return null;
    }
  }
}
