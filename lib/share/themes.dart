import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/share/style/colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
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
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: defaultColor,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey
  ),
);

ThemeData darkTheme =
    ThemeData(brightness: Brightness.dark, fontFamily: 'Jannah');
