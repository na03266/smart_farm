import 'package:drift/drift.dart' hide Column;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/database/drift.dart';

class TemperatureSettingScreen extends StatefulWidget {
  List<FlSpot> highData;
  List<FlSpot> lowData;

  TemperatureSettingScreen({
    super.key,
    required this.highData,
    required this.lowData,
  });

  @override
  State<TemperatureSettingScreen> createState() =>
      _TemperatureSettingScreenState();
}

class _TemperatureSettingScreenState extends State<TemperatureSettingScreen> {
  late bool isShowingMainData;
  late bool isConfigHighData;
  late bool isConfigLowData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
    isConfigHighData = false;
    isConfigLowData = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[2],
      appBar: AppBar(
        backgroundColor: colors[2],
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        /// 제목
        title: Text(
          "온도 설정",
          style: TextStyle(
              color: colors[6], fontSize: 32, fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: OutlinedButton(
              style: ButtonStyle(
                  elevation: WidgetStateProperty.all(10), // 그림자 높이 설정
                  backgroundColor: WidgetStateProperty.all(colors[7])),
              onPressed: onFinishPressed,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '완료',
                  style: TextStyle(
                    color: colors[6],
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            bottom: 24.0, left: 24.0, right: 24.0, top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ///제목 바, 완료 버튼

            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), // 가장자리 둥글게 처리
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: colors[2],
                      ),
                      BoxShadow(
                        offset: const Offset(1, 2),
                        blurRadius: 5,
                        spreadRadius: 2,
                        color: colors[1],
                        inset: true,
                      ),
                    ],
                  ),

                  ///chart
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: _LineChart(
                                  isShowingMainData: isShowingMainData,
                                  isConfigHighData: isConfigHighData,
                                  isConfigLowData: isConfigLowData,
                                  highData: widget.highData,
                                  lowData: widget.lowData,
                                  onPanUpdate: onChartPanUpdate,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.settings,
                                  size: 28,
                                  color: Colors.white.withOpacity(
                                      isShowingMainData ? 1.0 : 0.5),
                                ),
                                onPressed: () {
                                  setState(() {
                                    isShowingMainData = !isShowingMainData;
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.device_thermostat_rounded,
                                  size: 28,
                                  color: Colors.lightBlueAccent
                                      .withOpacity(isShowingMainData
                                          ? 0.0
                                          : isConfigHighData
                                              ? 1
                                              : 0.5),
                                ),
                                onPressed: () {
                                  setState(() {
                                    isConfigHighData = !isConfigHighData;
                                    if (isConfigLowData) {
                                      isConfigLowData = !isConfigLowData;
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.device_thermostat_rounded,
                                  size: 28,
                                  color: Colors.redAccent
                                      .withOpacity(isShowingMainData
                                          ? 0.0
                                          : isConfigLowData
                                              ? 1.0
                                              : 0.5),
                                ),
                                onPressed: () {
                                  setState(() {
                                    isConfigLowData = !isConfigLowData;
                                    if (isConfigHighData) {
                                      isConfigHighData = !isConfigHighData;
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onFinishPressed() async {
    final oldData = await GetIt.I<AppDatabase>().getTemperatures();
    for (int i = 0; i < 48; i++) {
      await GetIt.I<AppDatabase>().updateTempById(
          i + 1,
          TemperatureTableCompanion(
            time: Value(oldData[i].time),
            highTemp: Value(widget.highData[i].y),
            lowTemp: Value(widget.lowData[i].y),
          ));
    }
    Navigator.of(context).pop();
  }

  onChartPanUpdate(DragUpdateDetails details) {
    List<FlSpot> updatedHighData = List.from(widget.highData);
    List<FlSpot> updatedLowData = List.from(widget.lowData);

    for (int i = 0; i < 48; i++) {
      double coordinateX = details.globalPosition.dx;
      double timeX = 100 + 23.2 * i;
      double coordinateY = details.globalPosition.dy;

      /// tempY = a*y + b >> 화면 좌표 기준 온도 값 변환식
      double tempY = (5 * 660 / 51) - (50 / 510 * coordinateY);

      tempY = double.parse(tempY.toStringAsFixed(1));

      /// 그래프 안의 좌표만 허용
      bool timeCondition =
          coordinateX <= timeX + 11.6 && coordinateX >= timeX - 11.6;
      bool tempCondition = coordinateY <= 600 && coordinateY >= 150;

      double roundToNearestHalf(double value) {
        return (value * 2).round() / 2;
      }

      /// 표 오른쪽 바깥인 경우 행동안함
      if (timeCondition && tempCondition) {
        double roundedTempY = roundToNearestHalf(tempY);
        if (isConfigHighData) {
          // 높은 온도를 조절할 때
          updatedHighData[i] = FlSpot(i.toDouble() + 0.5, roundedTempY);

          // 만약 새로운 높은 온도가 현재 낮은 온도보다 낮다면, 낮은 온도도 함께 조정
          if (roundedTempY < updatedLowData[i].y) {
            updatedLowData[i] = FlSpot(i.toDouble() + 0.5, roundedTempY);
          }
        }
        if (isConfigLowData) {
          // 낮은 온도를 조절할 때
          updatedLowData[i] = FlSpot(i.toDouble() + 0.5, roundedTempY);

          // 만약 새로운 낮은 온도가 현재 높은 온도 보다 높다면, 높은 온도도 함께 조정
          if (roundedTempY > updatedHighData[i].y) {
            updatedHighData[i] = FlSpot(i.toDouble() + 0.5, roundedTempY);
          }
        }
      }
    }

    setState(() {
      widget.highData = updatedHighData;
      widget.lowData = updatedLowData;
    });
  }
}

class _LineChart extends StatefulWidget {
  final bool isShowingMainData;
  final bool isConfigHighData;
  final bool isConfigLowData;
  List<FlSpot> highData;
  List<FlSpot> lowData;
  final GestureDragUpdateCallback? onPanUpdate;

  _LineChart({
    required this.isShowingMainData,
    required this.isConfigHighData,
    required this.isConfigLowData,
    required this.lowData,
    required this.highData,
    required this.onPanUpdate,
  });

  @override
  State<_LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<_LineChart> {
  @override
  Widget build(BuildContext context) {
    /// 차트 전환
    return widget.isShowingMainData
        ? LineChart(
            mainChart,
            duration: const Duration(milliseconds: 250),
          )
        : (widget.isConfigHighData || widget.isConfigLowData)
            ? GestureDetector(
                /// 만약 높은 온도와 낮은온도가 교차하면?
                onPanUpdate: widget.onPanUpdate,
                child: LineChart(
                  settingChart,
                  duration: const Duration(milliseconds: 0),
                ),
              )
            : LineChart(
                settingChart,
                duration: const Duration(milliseconds: 0),
              );
  }

  LineChartData get mainChart => LineChartData(
        lineTouchData: mainlineTouchData,
        gridData: gridData,
        titlesData: mainTitlesData,
        borderData: borderData,
        lineBarsData: mainLineBarsData,
        minX: 0,
        maxX: 48,
        maxY: 50,
        minY: 0,
      );

  LineChartData get settingChart => LineChartData(
        lineTouchData: settingLineTouchData,
        gridData: gridData,
        titlesData: settingTitlesData,
        borderData: borderData,
        lineBarsData: settingLineBarsData,
        minX: 0,
        maxX: 48,
        maxY: 50,
        minY: 0,
      );

  /// 기본 차트
  LineTouchData get mainlineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => colors[1],
        ),
      );

  FlTitlesData get mainTitlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get mainLineBarsData => [
        mainHighLineChartBarData,
        mainLowLineChartBarData,
      ];

  /// 설정 차트
  LineTouchData get settingLineTouchData => LineTouchData(
        handleBuiltInTouches: false,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => colors[1],
        ),
      );

  FlTitlesData get settingTitlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get settingLineBarsData => [
        settingHighLineChartBarData,
        settingLowLineChartBarData,
      ];

  /// Y축 설명
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0.0';
        break;
      case 13:
        text = '12.5';
        break;
      case 25:
        text = '25.0';
        break;
      case 38:
        text = '37.5';
        break;
      case 50:
        text = '50.0';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  /// X축 설명
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('0', style: style);
        break;
      case 12:
        text = const Text('6', style: style);
        break;
      case 24:
        text = const Text('12', style: style);
        break;
      case 36:
        text = const Text('18', style: style);
        break;
      case 48:
        text = const Text('24', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: false);

  /// 차트 축 색상
  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
              color: const Color(0xFF50E4FF).withOpacity(0.2), width: 4),
          left: BorderSide(
              color: const Color(0xFF50E4FF).withOpacity(0.2), width: 4),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  /// 곡선
  LineChartBarData get mainHighLineChartBarData => LineChartBarData(
        isCurved: true,
        color: Colors.blueAccent,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: widget.highData,
      );

  LineChartBarData get mainLowLineChartBarData => LineChartBarData(
        isCurved: true,
        color: Colors.redAccent,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: widget.lowData,
      );

  ///꺽은선
  LineChartBarData get settingHighLineChartBarData => LineChartBarData(
        isCurved: false,
        curveSmoothness: 0,
        color: Colors.blueAccent.withOpacity(0.5),
        barWidth: 4,
        isStrokeCapRound: false,
        dotData: const FlDotData(show: false),
        aboveBarData: BarAreaData(
          show: true,
          color: Colors.blueAccent.withOpacity(0.2),
        ),
        spots: widget.highData,
      );

  LineChartBarData get settingLowLineChartBarData => LineChartBarData(
        isCurved: true,
        color: Colors.redAccent.withOpacity(0.5),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: Colors.redAccent.withOpacity(0.2),
        ),
        spots: widget.lowData,
      );
}
