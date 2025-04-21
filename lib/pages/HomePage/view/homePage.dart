import 'package:flutter/material.dart';
import 'package:routi_n/pages/HomePage/viewModel/homePageViewModel.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Homepageviewmodel viewModel;

  @override
  void initState() {
    viewModel = Homepageviewmodel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder:
          (context, child) => Scaffold(
            appBar: AppBar(title: Text('Title')),
            body: Container(color: Colors.amber),
          ),
    );
  }
}
