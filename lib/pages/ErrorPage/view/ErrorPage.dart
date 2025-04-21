import 'package:flutter/material.dart';
import 'package:routi_n/pages/ErrorPage/viewModel/ErrorPageViewModel.dart';

class Errorpage extends StatefulWidget {
  const Errorpage({super.key});

  @override
  State<Errorpage> createState() => ErrorpageState();
}

class ErrorpageState extends State<Errorpage> {
  late Errorpageviewmodel viewModel;

  @override
  void initState() {
    viewModel = Errorpageviewmodel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) => Scaffold(body: Text('Error page.')),
    );
  }
}
