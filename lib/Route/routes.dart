import 'package:flutter/cupertino.dart';

import 'package:routi_n/pages/ErrorPage/view/ErrorPage.dart';

import 'package:routi_n/pages/HomePage/view/homePage.dart';

class Routes {
  static const home = '/';
  static const login = '/login';
  static const second = 'second';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return CupertinoPageRoute(builder: (context) => Homepage());
      case login:
        return CupertinoPageRoute(builder: (context) => Errorpage());
      default:
        return CupertinoPageRoute(builder: (context) => Errorpage());
    }
  }
}
