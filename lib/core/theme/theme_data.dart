import 'package:flutter/material.dart';

ThemeData ligthThemeData = ThemeData(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Color(0xffca403b)))));

ThemeData darakThemeData = ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: const Color(0xff1c1c1e),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Color(0xffca403b)))));
