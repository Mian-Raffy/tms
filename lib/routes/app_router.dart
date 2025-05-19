import 'package:flutter/material.dart';
import 'package:tms_mobileapp/splash_screen.dart';
import 'package:tms_mobileapp/view/home_screen.dart';
import 'package:tms_mobileapp/view/single_project.dart';
import '../page_not_found.dart';
import '../view/sign_in.dart';
import 'pages.dart';

Route onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Pages.signin:
      return MaterialPageRoute(
        builder: (context) => SignInScreen(),
      );
    case Pages.splashScreen:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
    case Pages.home:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );

    case Pages.projectasks:
      return MaterialPageRoute(
        builder: (context) => SingleProjectScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const PageNotFound(),
      );
  }
}
