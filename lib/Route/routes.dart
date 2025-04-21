import 'package:flutter/cupertino.dart';

import 'package:routi_n/pages/ErrorPage/view/ErrorPage.dart';

import 'package:routi_n/pages/HomePage/view/homePage.dart';
import 'package:routi_n/pages/LoginPage/view/loginPage.dart';

class Routes {
  static const home = '/';
  static const login = '/login';
  static const error = 'error';

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return CupertinoPageRoute(builder: (context) => Homepage());
      case login:
        return CupertinoPageRoute(builder: (context) => Loginpage());
      case error:
        return CupertinoPageRoute(builder: (context) => Errorpage());
      default:
        return CupertinoPageRoute(builder: (context) => Errorpage());
    }
  }

  static String initialPageRouteName(AsyncSnapshot snapShot) {
    if (snapShot.hasData) {
      return home;
    } else {
      return login;
    }
  }
}
