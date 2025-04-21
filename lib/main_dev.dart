import 'package:flutter/material.dart';
import 'package:routi_n/Route/routes.dart';
import 'package:routi_n/pages/HomePage/view/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: Routes.home,
      onGenerateRoute: (settings) => Routes.generateRoute(settings),
    );
  }
}
