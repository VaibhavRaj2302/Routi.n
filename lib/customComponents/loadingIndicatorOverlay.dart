import 'package:flutter/material.dart';

class Loadingindicatoroverlay extends StatelessWidget {
  const Loadingindicatoroverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black38,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
