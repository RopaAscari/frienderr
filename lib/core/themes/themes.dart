import 'package:flutter/material.dart';
import 'package:frienderr/core/services/responsive_text.dart';
import 'package:frienderr/core/services/services.dart';

enum AppThemeTypes {
  light,
  dark,
}

class AppTheme {
  static late ScalingQuery _flutterResponsive;

  static AppTheme of(context) {
    _flutterResponsive = ResponsiveFlutter.of(context);
    return AppTheme();
  }

  final appThemeData = {
    AppThemeTypes.light: ThemeData(
      fontFamily: 'Inter',
      brightness: Brightness.light,
      primaryColor: HexColor('#F5F5F5'),
      canvasColor: HexColor('#FFFFFF'),
      textTheme: TextTheme(
        bodyText1: TextStyle(color: HexColor('#262527')),
        bodyText2: TextStyle(color: HexColor('#E4E3E3')),
      ).apply(
        bodyColor: HexColor('#262527'),
        displayColor: HexColor('#262527'),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    AppThemeTypes.dark: ThemeData(
      fontFamily: 'Inter',
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: HexColor('#767676').withOpacity(0.1),
      ),
      cardColor: HexColor('#9C9C9C').withOpacity(0.1),
      canvasColor: HexColor("#0e0e11"), // HexColor('#000000'),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      popupMenuTheme: PopupMenuThemeData(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      textTheme: TextTheme(
        bodyText1: TextStyle(
            color: Colors.grey[500],
            fontSize: _flutterResponsive.fontSize(1.5)),
        bodyText2: const TextStyle(color: Colors.white),
      ),
    ),
  };
}
