import 'package:flutter/material.dart';
import 'package:routi_n/customComponents/RNDrawer.dart';
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
        (index) => DummyWidgetForTesting(
          state: viewModel.viewState.pageState,
          date: index.toString(),
          didUpdateWidget: () async {
            await viewModel.futureFunctionForTesting();
          },
        ),
      ),
    );
  }
}

class DummyWidgetForTesting extends StatefulWidget {
  DummyWidgetForTesting({
    required this.state,
    required this.date,
    required this.didUpdateWidget,
    super.key,
  });
  PageState state;
  String date;
  Function() didUpdateWidget;

  @override
  State<DummyWidgetForTesting> createState() => _DummyWidgetForTestingState();
}

class _DummyWidgetForTestingState extends State<DummyWidgetForTesting> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.didUpdateWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('${widget.state} and ${widget.date}'));
  }
}
