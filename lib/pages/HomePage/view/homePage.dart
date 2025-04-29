import 'package:flutter/material.dart';
import 'package:routi_n/customComponents/RNDrawer.dart';
import 'package:routi_n/pages/HomePage/viewModel/homePageViewModel.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late Homepageviewmodel viewModel;

  late TabController tabBarController;

  final tabs = [
    Container(color: Colors.amber, height: 30),
    Container(color: Colors.green, height: 30),
    Container(color: Colors.blue, height: 30),
    Container(color: Colors.pink, height: 30),
    Container(color: Colors.purple, height: 30),
    Container(color: Colors.purple, height: 30),
    Container(color: Colors.purple, height: 30),
    Container(color: Colors.purple, height: 30),
    Container(color: Colors.purple, height: 30),
    Container(color: Colors.purple, height: 30),
  ];

  @override
  void initState() {
    viewModel = Homepageviewmodel();
    tabBarController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder:
          (context, child) => Scaffold(
            drawer: Rndrawer(
              crossButton: () {
                Navigator.pop(context);
              },
              logoutButton: () => viewModel.logout(),
            ),
            appBar: AppBar(title: Text('Title')),
            body: customTabBar(),
          ),
    );
  }

  Widget customTabBar() {
    return TabBar(controller: tabBarController, tabs: tabs);
  }
}
