import 'package:fl_chart/fl_chart.dart';

final exData = [
// 온도 데이터
  [
    FlSpot(0, 22),
    FlSpot(1, 21),
    FlSpot(2, 20),
    FlSpot(3, 19),
    FlSpot(4, 18),
    FlSpot(5, 17),
    FlSpot(6, 16),
    FlSpot(7, 17),
    FlSpot(8, 18),
    FlSpot(9, 20),
    FlSpot(10, 22),
    FlSpot(11, 24),
    FlSpot(12, 26),
    FlSpot(13, 27),
    FlSpot(14, 28),
    FlSpot(15, 29),
    FlSpot(16, 28),
    FlSpot(17, 27),
    FlSpot(18, 26),
    FlSpot(19, 25),
    FlSpot(20, 24),
    FlSpot(21, 23),
    FlSpot(22, 22),
    FlSpot(23, 21),
// ... (추가 25개 데이터 포인트)
  ],

// 습도 데이터
  [
    FlSpot(0, 65),
    FlSpot(1, 67),
    FlSpot(2, 69),
    FlSpot(3, 70),
    FlSpot(4, 72),
    FlSpot(5, 74),
    FlSpot(6, 75),
    FlSpot(7, 73),
    FlSpot(8, 70),
    FlSpot(9, 68),
    FlSpot(10, 65),
    FlSpot(11, 62),
    FlSpot(12, 60),
    FlSpot(13, 58),
    FlSpot(14, 55),
    FlSpot(15, 53),
    FlSpot(16, 55),
    FlSpot(17, 57),
    FlSpot(18, 60),
    FlSpot(19, 62),
    FlSpot(20, 64),
    FlSpot(21, 66),
    FlSpot(22, 68),
    FlSpot(23, 70),
// ... (추가 25개 데이터 포인트)
  ],

// 대기압 데이터
  [
    FlSpot(0, 1013),
    FlSpot(1, 1012),
    FlSpot(2, 1012),
    FlSpot(3, 1011),
    FlSpot(4, 1011),
    FlSpot(5, 1010),
    FlSpot(6, 1010),
    FlSpot(7, 1011),
    FlSpot(8, 1012),
    FlSpot(9, 1013),
    FlSpot(10, 1014),
    FlSpot(11, 1015),
    FlSpot(12, 1015),
    FlSpot(13, 1014),
    FlSpot(14, 1014),
    FlSpot(15, 1013),
    FlSpot(16, 1013),
    FlSpot(17, 1012),
    FlSpot(18, 1012),
    FlSpot(19, 1011),
    FlSpot(20, 1011),
    FlSpot(21, 1012),
    FlSpot(22, 1012),
    FlSpot(23, 1013),
// ... (추가 25개 데이터 포인트)
  ],

// 조도 데이터
  [
    FlSpot(0, 0),
    FlSpot(1, 0),
    FlSpot(2, 0),
    FlSpot(3, 0),
    FlSpot(4, 0),
    FlSpot(5, 100),
    FlSpot(6, 1000),
    FlSpot(7, 5000),
    FlSpot(8, 20000),
    FlSpot(9, 50000),
    FlSpot(10, 80000),
    FlSpot(11, 95000),
    FlSpot(12, 100000),
    FlSpot(13, 95000),
    FlSpot(14, 80000),
    FlSpot(15, 50000),
    FlSpot(16, 20000),
    FlSpot(17, 5000),
    FlSpot(18, 1000),
    FlSpot(19, 100),
    FlSpot(20, 0),
    FlSpot(21, 0),
    FlSpot(22, 0),
    FlSpot(23, 0),
// ... (추가 25개 데이터 포인트)
  ],

// 이산화탄소 데이터
  [
    FlSpot(0, 450),
    FlSpot(1, 460),
    FlSpot(2, 470),
    FlSpot(3, 480),
    FlSpot(4, 490),
    FlSpot(5, 500),
    FlSpot(6, 510),
    FlSpot(7, 500),
    FlSpot(8, 490),
    FlSpot(9, 480),
    FlSpot(10, 470),
    FlSpot(11, 460),
    FlSpot(12, 450),
    FlSpot(13, 440),
    FlSpot(14, 430),
    FlSpot(15, 420),
    FlSpot(16, 430),
    FlSpot(17, 440),
    FlSpot(18, 450),
    FlSpot(19, 460),
    FlSpot(20, 470),
    FlSpot(21, 480),
    FlSpot(22, 490),
    FlSpot(23, 500),
// ... (추가 25개 데이터 포인트)
  ],

// 산성도 데이터
  [
    FlSpot(0, 6.5),
    FlSpot(1, 6.5),
    FlSpot(2, 6.4),
    FlSpot(3, 6.4),
    FlSpot(4, 6.3),
    FlSpot(5, 6.3),
    FlSpot(6, 6.2),
    FlSpot(7, 6.2),
    FlSpot(8, 6.3),
    FlSpot(9, 6.3),
    FlSpot(10, 6.4),
    FlSpot(11, 6.4),
    FlSpot(12, 6.5),
    FlSpot(13, 6.5),
    FlSpot(14, 6.6),
    FlSpot(15, 6.6),
    FlSpot(16, 6.5),
    FlSpot(17, 6.5),
    FlSpot(18, 6.4),
    FlSpot(19, 6.4),
    FlSpot(20, 6.3),
    FlSpot(21, 6.3),
    FlSpot(22, 6.2),
    FlSpot(23, 6.2),
// ... (추가 25개 데이터 포인트)
  ],

// 토양 온도 데이터
  [
    FlSpot(0, 18),
    FlSpot(1, 17.5),
    FlSpot(2, 17),
    FlSpot(3, 16.5),
    FlSpot(4, 16),
    FlSpot(5, 15.5),
    FlSpot(6, 15),
    FlSpot(7, 15.5),
    FlSpot(8, 16),
    FlSpot(9, 17),
    FlSpot(10, 18),
    FlSpot(11, 19),
    FlSpot(12, 20),
    FlSpot(13, 21),
    FlSpot(14, 22),
    FlSpot(15, 22.5),
    FlSpot(16, 22),
    FlSpot(17, 21.5),
    FlSpot(18, 21),
    FlSpot(19, 20.5),
    FlSpot(20, 20),
    FlSpot(21, 19.5),
    FlSpot(22, 19),
    FlSpot(23, 18.5),
// ... (추가 25개 데이터 포인트)
  ],

// 토양 습도 데이터
  [
    FlSpot(0, 35),
    FlSpot(1, 34),
    FlSpot(2, 33),
    FlSpot(3, 32),
    FlSpot(4, 31),
    FlSpot(5, 30),
    FlSpot(6, 29),
    FlSpot(7, 30),
    FlSpot(8, 31),
    FlSpot(9, 32),
    FlSpot(10, 33),
    FlSpot(11, 34),
    FlSpot(12, 35),
    FlSpot(13, 36),
    FlSpot(14, 37),
    FlSpot(15, 38),
    FlSpot(16, 37),
    FlSpot(17, 36),
    FlSpot(18, 35),
    FlSpot(19, 34),
    FlSpot(20, 33),
    FlSpot(21, 32),
    FlSpot(22, 31),
    FlSpot(23, 30),
// ... (추가 25개 데이터 포인트)
  ],

// 전기 전도도 데이터
  [
    FlSpot(0, 1.5),
    FlSpot(1, 1.5),
    FlSpot(2, 1.4),
    FlSpot(3, 1.4),
    FlSpot(4, 1.3),
    FlSpot(5, 1.3),
    FlSpot(6, 1.2),
    FlSpot(7, 1.2),
    FlSpot(8, 1.3),
    FlSpot(9, 1.3),
    FlSpot(10, 1.4),
    FlSpot(11, 1.4),
    FlSpot(12, 1.5),
    FlSpot(13, 1.5),
    FlSpot(14, 1.6),
    FlSpot(15, 1.6),
    FlSpot(16, 1.5),
    FlSpot(17, 1.5),
    FlSpot(18, 1.4),
    FlSpot(19, 1.4),
    FlSpot(20, 1.3),
    FlSpot(21, 1.3),
    FlSpot(22, 1.2),
    FlSpot(23, 1.2),
// ... (추가 25개 데이터 포인트)
  ],
];