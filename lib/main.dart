import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/database/drift.dart';
import 'package:smart_farm/provider/data_provider.dart';
import 'package:smart_farm/screens/home_screen.dart';
import 'package:smart_farm/service/socket_service.dart';

void main() async {
  // 위젯 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  // 화면을 가로 방향으로 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // 데이터베이스 초기화 및 등록
  final database = AppDatabase();
  GetIt.I.registerSingleton<AppDatabase>(database);

  // SocketService
  final dataProvider = DataProvider();
  GetIt.I.registerSingleton<DataProvider>(dataProvider);
  final socketService = SocketService(dataProvider);
  GetIt.I.registerSingleton<SocketService>(socketService);

  // 서버 연결 시도
  connectToServer();

  runApp(
    ScreenUtilInit(
      designSize: const Size(1280, 800), // 디자인 기준 크기
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => GetIt.I<DataProvider>()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: TextTheme(
                displayLarge: TextStyle(
                  color: Colors.white,
                  fontSize: 80.sp,
                ),
                displayMedium: TextStyle(
                  color: Colors.white,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                ),
                displaySmall: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            home: const HomeScreen(),
          ),
        );
      },
    ),
  );
}

void connectToServer() async {
  try {
    await GetIt.I<SocketService>().connectToServer();
    print('서버에 연결되었습니다.');
    GetIt.I<SocketService>().requestData();
  } catch (e) {
    print('초기 서버 연결 실패: $e');
    // 재연결은 SocketService 내부에서 자동으로 처리됩니다.
  }
}
