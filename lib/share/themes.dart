import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/share/style/colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: PrimaryColor,
  accentColor: AccentColor,
  fontFamily: 'Jannah',
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
    ),
    iconTheme:IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle:TextStyle(
      color: Colors.white,
    )
  ),
);

ThemeData darkTheme =
    ThemeData(brightness: Brightness.dark, fontFamily: 'Jannah');
