import 'package:flutter/material.dart';
import 'package:routi_n/customComponents/homePageListTiles.dart';
import 'package:routi_n/pages/HomePage/view/homePage.dart';

class Customlistview<T> extends StatefulWidget {
  Customlistview({required this.items, required this.updateWidget, super.key});
  List<T> items;
  Function() updateWidget;

  @override
  State<Customlistview> createState() => _CustomlistviewState();
}

class _CustomlistviewState extends State<Customlistview> {
  @override
  void initState() {
    widget.updateWidget();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(10),
      itemBuilder:
          (context, index) => Homepagelisttiles(details: widget.items[index]),
      separatorBuilder:
          (context, index) => Divider(
            color: Colors.blue,
            endIndent: 10,
            indent: 10,
            thickness: 2,
          ),
      itemCount: widget.items.length,
    );
  }
}
