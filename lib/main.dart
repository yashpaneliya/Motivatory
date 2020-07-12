import 'package:flutter/material.dart';
import 'package:motivatory/resources/colors.dart';
import 'Screens/Homepage.dart';

bool dark = true;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Motivatory',
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        elevation: 0.0
      ),
      backgroundColor: background,
      // colorScheme: ColorScheme(primary: background, primaryVariant: Colors.black, secondary: Colors.white, secondaryVariant: Colors.white, surface: catcolor, background: background, error: red, onPrimary: null, onSecondary: null, onSurface: null, onBackground: null, onError: null, brightness: Brightness.dark),
      fontFamily: 'R',
      primarySwatch: MaterialColor(1, {1: background, 2: Colors.white}),
      brightness: dark ? Brightness.dark : Brightness.light,
    ),
    home: Homepage(),
  ));
}
