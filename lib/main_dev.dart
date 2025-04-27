import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routi_n/Route/routes.dart';
import 'package:routi_n/Themes/appTheme.dart';
import 'package:routi_n/firebase_options.dart';
import 'package:routi_n/pages/ErrorPage/view/ErrorPage.dart';
import 'package:routi_n/pages/HomePage/view/homePage.dart';
import 'package:routi_n/pages/LoginPage/view/loginPage.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  ); // Initialize Firebase

  FirebaseAuthListeners();

  usePathUrlStrategy();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userState(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Material(child: Center(child: CircularProgressIndicator()));
        }
        return MaterialApp(
          title: 'Flutter Demo',
          navigatorKey: Routes.navigatorKey,
          theme: Apptheme.lightThemeData,
          darkTheme: Apptheme.darkThemeData,
          initialRoute: Routes.initialPageRouteName(snapshot),
          onGenerateRoute: (settings) => Routes.generateRoute(settings),
          routes: {
            Routes.home: (context) => Homepage(),
            Routes.login: (context) => Loginpage(),
            Routes.error: (context) => Errorpage(),
          },
        );
      },
    );
  }

  Future<User?> userState() async {
    return FirebaseAuth.instance.currentUser;
  }
}

class FirebaseAuthListeners {
  FirebaseAuthListeners() {
    _initializeListeners();
  }

  void _initializeListeners() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
        navigateToLogin();
      } else {
        navigateToHomePage();
      }
    });

    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (user != null) {
        debugPrint('ID Token changed for user: ${user.uid}');
        navigateToHomePage();
      } else {
        navigateToLogin();
      }
    });

    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user != null) {
        debugPrint('User profile changed: ${user.displayName}');
        navigateToHomePage();
      } else {
        navigateToLogin();
      }
    });
  }

  static void navigateToLogin() {
    if (Routes.navigatorKey.currentContext != null) {
      Navigator.of(
        Routes.navigatorKey.currentContext!,
      ).pushNamedAndRemoveUntil(Routes.login, (route) => false);
    }
  }

  static void navigateToHomePage() {
    if (Routes.navigatorKey.currentContext != null) {
      Navigator.of(
        Routes.navigatorKey.currentContext!,
      ).pushNamedAndRemoveUntil(Routes.home, (route) => false);
    }
  }
}
