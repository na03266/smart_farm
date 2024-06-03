import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:smart_farm/consts/app_colors.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/consts/temp.dart';

class TemperatureSettingModal extends StatefulWidget {
  const TemperatureSettingModal({
    super.key,
  });

  @override
  State<TemperatureSettingModal> createState() =>
      _TemperatureSettingModalState();
}

class _TemperatureSettingModalState extends State<TemperatureSettingModal> {
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ///제목 바, 완료 버튼
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "온도 설정",
                    style: TextStyle(
                        color: colors[6],
                        fontSize: 32,
                        fontWeight: FontWeight.w700),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        elevation: WidgetStateProperty.all(10), // 그림자 높이 설정
                        backgroundColor: WidgetStateProperty.all(colors[7])),
                    onPressed: () {},
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
                ],
              ),
            ),
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
}

class _LineChart extends StatefulWidget {
  final bool isShowingMainData;
  final bool isConfigHighData;
  final bool isConfigLowData;

  const _LineChart({
    required this.isShowingMainData,
    required this.isConfigHighData,
    required this.isConfigLowData,
  });

  @override
  State<_LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<_LineChart> {
  List<FlSpot> highData = generateHighTempData()
      .map(
        (HighTemperatureInfo e) => FlSpot(
          e.highTime + 0.1,
          e.highTemp,
        ),
      )
      .toList();

  List<FlSpot> lowData = generateLowTempData()
      .map(
        (LowTemperatureInfo e) => FlSpot(
          e.lowTime + 0.1,
          e.lowTemp,
        ),
      )
      .toList();

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
                onPanUpdate: (details) {
                  List<FlSpot> updatedHighData = List.from(highData);
                  List<FlSpot> updatedLowData = List.from(lowData);

                  for (int i = 0; i < 49; i++) {
                    double coordinateX = details.globalPosition.dx;
                    double timeX = 215 + 19.2 * i;
                    double coordinateY = details.globalPosition.dy;

                    /// tempY = a*y + b >> 화면 좌표 기준 온도 값 변환식
                    double tempY = (5 * 580 / 31) - (5 / 31 * coordinateY);

                    tempY = double.parse(tempY.toStringAsFixed(1));

                    /// 그래프 안의 좌표만 허용
                    bool timeCondition = coordinateX <= timeX + 9.6 &&
                        coordinateX >= timeX - 9.6;
                    bool tempCondition =
                        coordinateY <= 580 && coordinateY >= 270;

                    /// 표 오른쪽 바깥인 경우 행동안함
                    if (timeCondition && tempCondition) {
                      print(tempY);
                      if (widget.isConfigHighData) {
                        updatedHighData[i] = FlSpot(i.toDouble(), tempY);
                      }
                      if (widget.isConfigLowData) {
                        updatedLowData[i] = FlSpot(i.toDouble(), tempY);
                      }
                    }
                  }

                  setState(() {
                    if (widget.isConfigHighData) highData = updatedHighData;
                    if (widget.isConfigLowData) lowData = updatedLowData;
                  });
                },
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
        handleBuiltInTouches: true,
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
          bottom:
              BorderSide(color: AppColors.primary.withOpacity(0.2), width: 4),
          left: BorderSide(color: AppColors.primary.withOpacity(0.2), width: 4),
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
        spots: highData,
      );

  LineChartBarData get mainLowLineChartBarData => LineChartBarData(
        isCurved: true,
        color: Colors.redAccent,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: lowData,
      );

  ///꺽은선
  LineChartBarData get settingHighLineChartBarData => LineChartBarData(
        isCurved: false,
        curveSmoothness: 0,
        color: Colors.blueAccent.withOpacity(0.5),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        aboveBarData: BarAreaData(
          show: true,
          color: Colors.blueAccent.withOpacity(0.2),
        ),
        spots: highData,
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
        spots: lowData,
      );
}
