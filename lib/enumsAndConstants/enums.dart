import 'package:flutter/material.dart';

enum PageState { loading, success, successShow, error, errorShow }

enum DrawerButtonItems {
  pendingTasks(icon: Icons.pending),
  completedTasks(icon: Icons.cloud_done_sharp);

  final IconData? icon;
  const DrawerButtonItems({this.icon});
}
