import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/database/drift.dart';
import 'package:smart_farm/provider/data_provider.dart';
import 'package:smart_farm/screens/intro_screen.dart';
import 'package:smart_farm/service/socket_service.dart';

void main() async {
  /// 위젯 바인딩 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();

  /// 데이터베이스 초기화 및 등록
  final database = AppDatabase();
  GetIt.I.registerSingleton<AppDatabase>(database);

  /// SocketService
  final dataProvider = DataProvider();

  final socketService = SocketService(dataProvider);
  GetIt.I.registerSingleton<SocketService>(socketService);
  try {
    await GetIt.I<SocketService>().connectToServer();
    print('서버에 연결되었습니다.');
  } catch (e) {
    print('서버 연결 실패: $e');
  }

  runApp(
    ///Provider 등록
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => dataProvider),
      ],
      child: MaterialApp(
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
    ),
  );
}
