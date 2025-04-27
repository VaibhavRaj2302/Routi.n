import 'package:flutter/material.dart';

class Rnsnackbar extends SnackBar {
  Rnsnackbar({
    required String message,
    super.key,
    bool showCloseIcon = true,
    SnackBarAction? snackBarActionButton,
  }) : super(
         content: Row(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisSize: MainAxisSize.max,
           spacing: 10,
           children: [
             Image.asset('assets/AppIcon/APP icon.png', height: 30, width: 30),
             Expanded(
               child: Text(
                 message,
                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
               ),
             ),
           ],
         ),
         showCloseIcon: showCloseIcon,
         action: snackBarActionButton,
         behavior: SnackBarBehavior.floating,
         duration: Duration(seconds: 15),
         padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
       );
}
