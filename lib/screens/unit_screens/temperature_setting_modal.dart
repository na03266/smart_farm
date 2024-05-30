import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:smart_farm/consts/app_colors.dart';
import 'package:smart_farm/consts/colors.dart';

class TemperatureSettingModal extends StatefulWidget {
  /// Unit Model 수정해야함.
  const TemperatureSettingModal({
    super.key,
  });

  @override
  State<TemperatureSettingModal> createState() =>
      _TemperatureSettingModalState();
}

class _TemperatureSettingModalState extends State<TemperatureSettingModal> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
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
                    aspectRatio: 1.23,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 37,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 16, left: 6),
                                child: _LineChart(
                                    isShowingMainData: isShowingMainData),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.settings,
                                color: Colors.white
                                    .withOpacity(isShowingMainData ? 1.0 : 0.5),
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
                                color: Colors.redAccent
                                    .withOpacity(isShowingMainData ? 0.0 : 1.0),
                              ),
                              onPressed: () {
                                setState(() {
                                  /// 값 해당 줄만 변경할수있도록
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.device_thermostat_rounded,
                                color: Colors.lightBlueAccent
                                    .withOpacity(isShowingMainData ? 0.0 : 1.0),
                              ),
                              onPressed: () {
                                setState(() {
                                  /// 값 해당 줄만 변경할수있도록
                                });
                              },
                            ),
                          ],
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

class _LineChart extends StatelessWidget {
  const _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      isShowingMainData ? sampleData1 : sampleData2,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 14,
        maxY: 4,
        minY: 0,
      );

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: 14,
        maxY: 6,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
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

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
      ];

  LineTouchData get lineTouchData2 => const LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
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

  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData2_1,
        lineChartBarData2_2,
        lineChartBarData2_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '1';
        break;
      case 2:
        text = '25';
        break;
      case 4:
        text = '50';
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

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('0', style: style);
        break;
      case 7:
        text = const Text('12', style: style);
        break;
      case 24:
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

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: AppColors.primary.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: AppColors.contentColorGreen,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: AppColors.contentColorPink,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: AppColors.contentColorPink.withOpacity(0),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        color: AppColors.contentColorCyan,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 2.8),
          FlSpot(3, 1.9),
          FlSpot(6, 3),
          FlSpot(10, 1.3),
          FlSpot(13, 2.5),
        ],
      );

  LineChartBarData get lineChartBarData2_1 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: AppColors.contentColorGreen.withOpacity(0.5),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
        isCurved: true,
        color: AppColors.contentColorPink.withOpacity(0.5),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: AppColors.contentColorPink.withOpacity(0.2),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData2_3 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: AppColors.contentColorCyan.withOpacity(0.5),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 3.8),
          FlSpot(3, 1.9),
          FlSpot(6, 5),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
      );
}
