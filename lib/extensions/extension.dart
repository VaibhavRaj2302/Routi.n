import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

extension ColorHex on Color {
  static Color fromString(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
