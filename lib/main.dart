import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_farm/database/drift.dart';
import 'package:smart_farm/screens/intro_screen.dart';

void main() async {
  /// 위젯 바인딩 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();

  /// 전역 상태 관리 가능
  GetIt.I.registerSingleton<AppDatabase>(database);

  final resp = await database.getTimers();

  print(resp);
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
