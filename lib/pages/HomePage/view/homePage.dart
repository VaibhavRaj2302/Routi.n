import 'package:flutter/material.dart';
import 'package:routi_n/customComponents/RNDrawer.dart';
import 'package:routi_n/customComponents/customListView.dart';
import 'package:routi_n/customComponents/loadingIndicatorOverlay.dart';
import 'package:routi_n/enumsAndConstants/enums.dart';
import 'package:routi_n/pages/HomePage/viewModel/homePageViewModel.dart';
import 'package:routi_n/utility/helperFunction.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late Homepageviewmodel viewModel;

  late TabController tabBarController;

  late List<Widget> tabs;

  List<Widget> getTextWidgetForDateTime() {
    final now = DateTime.now();

    return List.generate(7, (index) {
      final date = now.add(Duration(days: index));
      return Text(
        Helperfunction.convertDateTimeToHumanReadable(date: date),
        style: TextStyle(fontSize: 16),
      );
    });
  }

  @override
  void initState() {
    tabs = getTextWidgetForDateTime();
    viewModel = Homepageviewmodel();
    viewModel.addListener(viewModelDidUpdated);
    tabBarController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  void viewModelDidUpdated() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder:
          (context, child) => Stack(
            children: [
              Scaffold(
                drawer: Rndrawer(
                  crossButton: () {
                    Navigator.pop(context);
                  },
                  logoutButton: () => viewModel.logout(),
                ),
                appBar: AppBar(title: Text('Title'), bottom: customTabBar()),

                body: customTabBarView(),
              ),
              if (viewModel.viewState.pageState == PageState.loading)
                Loadingindicatoroverlay(),
            ],
          ),
    );
  }

  TabBar customTabBar() {
    return TabBar(
      controller: tabBarController,
      tabs: tabs,
      isScrollable: true,
      labelPadding: EdgeInsets.all(10),
    );
  }

  Widget customTabBarView() {
    return TabBarView(
      controller: tabBarController,
      children: List.generate(
        tabBarController.length,
        (index) => Customlistview<DummyDataModel>(
          items: List.generate(
            20,
            (index) => DummyDataModel.generateDummyDate(),
          ),
          updateWidget: () async => viewModel.futureFunctionForTesting(),
        ),
      ),
    );
  }
}

class DummyDataModel {
  DummyDataModel({
    this.caption,
    this.endDateTime,
    this.startDateTime,
    this.subTitle,
    this.title,
  });

  String? title;
  String? subTitle;
  String? caption;
  DateTime? startDateTime;
  DateTime? endDateTime;

  factory DummyDataModel.generateDummyDate() => DummyDataModel(
    caption:
        'This is a dummy caption text created for testing purposes. It contains exactly one hundred words to ensure proper functionality and testing of the application. The purpose of this text is to simulate real-world data that might be used in the application. By using this text, developers can verify that the UI components and logic handle longer strings correctly. This caption serves as a placeholder and can be replaced with actual data when the application is deployed. Testing with such text ensures robustness and reliability of the application under various scenarios.',
    endDateTime: DateTime.now().add(Duration(days: 7)),
    startDateTime: DateTime.now().subtract(Duration(days: 2)),
    subTitle:
        'This is some title which is subtitle and show major captions or reason for tasks.',
    title: 'This is title',
  );
}
