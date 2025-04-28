import 'package:flutter/material.dart';
import 'package:routi_n/extensions/extension.dart';

class Apptheme {
  // light theme
  static Color lightThemeBackground = Colors.white;
  static Color lightThemeText = Colors.black;
  static Color lightThemeTextFieldColor = Colors.orange;
  static Color lightThemeButtonIcon = Colors.red;
  static Color lightThemeSeedColor = Colors.lightBlue;

  // dark theme
  static Color darkTheme1 = ColorHex.fromString('#E19898');
  static Color darkTheme2 = ColorHex.fromString('#A2678A');
  static Color darkTheme3 = ColorHex.fromString('#4D3C77');
  static Color darkTheme4 = ColorHex.fromString('#3F1D38');

  // dark theme data
  static ThemeData darkThemeData = ThemeData(
    scaffoldBackgroundColor: darkTheme4,
  );

  // light theme data
  static ThemeData lightThemeData = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: lightThemeSeedColor),

    scaffoldBackgroundColor: lightThemeBackground,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey;
          }
          return Colors.white;
        }),
        foregroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.white;
          }
          return lightThemeText;
        }),
        shape: WidgetStateOutlinedBorder.resolveWith((states) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.black, width: 1),
          );
        }),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white70,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: lightThemeTextFieldColor,
          strokeAlign: 10,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.red, strokeAlign: 10),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey, strokeAlign: 10),
      ),
    ),
  );

  static TextStyle get loginTextStyle => TextStyle(
    color: lightThemeText,
    fontSize: 26,
    fontWeight: FontWeight.w600,
  );

  static ButtonStyle get loginSignUpButtonStyle => ButtonStyle(
    shape: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(3));
      }
      if (states.contains(WidgetState.hovered)) {
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(30));
      }
      return RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
    }),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.grey.shade100;
      }
      if (states.contains(WidgetState.hovered)) {
        return Colors.green.shade100;
      }
      return Colors.white;
    }),
    foregroundColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.grey.shade900;
      }
      if (states.contains(WidgetState.hovered)) {
        return Colors.green.shade900;
      }
      return Colors.black;
    }),
  );

  static ButtonStyle get loginSignUpProviderButtonStyle => ButtonStyle(
    shape: WidgetStateProperty.resolveWith((states) {
      return RoundedRectangleBorder(borderRadius: BorderRadius.circular(5));
    }),
    side: WidgetStateBorderSide.resolveWith((states) {
      return BorderSide(color: Colors.black, width: 1);
    }),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      return Colors.white;
    }),
    foregroundColor: WidgetStateColor.resolveWith((states) {
      return Colors.black;
    }),
  );
}
