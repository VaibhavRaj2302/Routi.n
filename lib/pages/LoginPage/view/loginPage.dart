import 'package:flutter/material.dart';
import 'package:routi_n/pages/LoginPage/viewModel/loginPageViewModel.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  late Loginpageviewmodel viewModel;

  @override
  void initState() {
    viewModel = Loginpageviewmodel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) => Scaffold(body: mainTile()),
    );
  }

  Widget mainTile() {
    return Container();
  }
}
