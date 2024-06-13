import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/provider/unit_provider.dart';
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
      /// 하위 페이지에서 ChangeNotifierProvider 접근 가능
      home: const IntroScreen(),
    ),
  );
}
