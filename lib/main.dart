import 'package:flutter/material.dart';
import 'package:smart_farm/screens/intro_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // fontFamily: 여기에 기본 폰트 지정 가능,
          textTheme: const TextTheme(
              displayLarge: TextStyle(
                color: Colors.white,
                fontSize: 80,
                // fontFamily:
              ),
              displayMedium: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
              displaySmall: TextStyle(
                color: Colors.white,
              ))),
      home: const IntroScreen(),
    ),
  );
}
