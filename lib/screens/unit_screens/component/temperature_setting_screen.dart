import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_farm/consts/colors.dart';

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
  String selectedTime = '';
  String selectedTemperature = '';

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
              color: colors[6], fontSize: 32.sp, fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 32.0.w),
            child: OutlinedButton(
              style: ButtonStyle(
                  elevation: WidgetStateProperty.all(10), // 그림자 높이 설정
                  backgroundColor: WidgetStateProperty.all(colors[7])),
              onPressed: onFinishPressed,
              child: Padding(
                padding: EdgeInsets.all(8.0.r),
                child: Text(
                  '완료',
                  style: TextStyle(
                    color: colors[6],
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.0.w, 8.0.h, 24.0.w, 24.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ///제목 바, 완료 버튼
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(8.0.r),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: colors[2],
                      ),
                      BoxShadow(
                        offset: Offset(1.w, 2.h),
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
                            SizedBox(height: 40.h),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(20.r),
                                child: _LineChart(
                                  isShowingMainData: isShowingMainData,
                                  isConfigHighData: isConfigHighData,
                                  isConfigLowData: isConfigLowData,
                                  highData: widget.highData,
                                  lowData: widget.lowData,
                                  onPanUpdate: onChartPanUpdate,
                                  onTimeSelected: (time) {
                                    setState(() {
                                      selectedTime = time;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.settings,
                                  size: 28.sp,
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
                                  size: 28.sp,
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
                                  size: 28.sp,
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
                              const Expanded(child: SizedBox()),
                              Text(
                                isShowingMainData
                                    ? '선택된 시간: $selectedTime'
                                    : '선택된 시간: $selectedTime   선택된 온도: $selectedTemperature°C',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24.sp,
                                ),
                              ),
                              SizedBox(width: 30.w)
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
    final tempL =
        List.generate(48, (index) => (widget.lowData[index].y.toInt()));
    final tempH =
        List.generate(48, (index) => (widget.highData[index].y.toInt()));

    /// 높은 값과 낮은 값 리스트로 반환
    Navigator.of(context).pop([tempL, tempH]);
  }

  onChartPanUpdate(DragUpdateDetails details) {
    List<FlSpot> updatedHighData = List.from(widget.highData);
    List<FlSpot> updatedLowData = List.from(widget.lowData);

    // 차트의 크기와 위치를 계산
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset position = renderBox.localToGlobal(Offset.zero);

    // 차트의 실제 범위 계산
    double chartLeft = position.dx;
    double chartRight = position.dx + size.width;
    double chartTop = position.dy;
    double chartBottom = position.dy + size.height;

    // X축과 Y축의 스케일 계산
    double xScale = size.width / 48;
    double yScale = size.height / 50; // 온도 범위가 0-50이라고 가정

    for (int i = 0; i < 48; i++) {
      double coordinateX = details.globalPosition.dx;
      double timeX = chartLeft + xScale * i;
      double coordinateY = details.globalPosition.dy;

      // 온도 계산 (Y축 반전 고려)
      double tempY = 50 - (coordinateY - chartTop) / yScale;
      tempY = double.parse(tempY.toStringAsFixed(1));

      // 그래프 안의 좌표만 허용
      bool timeCondition = coordinateX <= timeX + xScale / 2 &&
          coordinateX >= timeX - xScale / 2;
      bool tempCondition =
          coordinateY <= chartBottom && coordinateY >= chartTop;

      double roundToNearestHalf(double value) {
        return value.toInt().toDouble();
      }

      if (timeCondition && tempCondition) {
        double roundedTempY = roundToNearestHalf(tempY);
        setState(() {
          selectedTime =
              '${(i ~/ 2).toString().padLeft(2, '0')}:${(i % 2 * 30).toString().padLeft(2, '0')}';
          selectedTemperature = roundedTempY.toStringAsFixed(1);
        });

        if (isConfigHighData) {
          updatedHighData[i] = FlSpot(i.toDouble() + 0.5, roundedTempY);
          print(updatedHighData[i]);
          if (roundedTempY < updatedLowData[i].y) {
            updatedLowData[i] = FlSpot(i.toDouble() + 0.5, roundedTempY);
          }
        }
        if (isConfigLowData) {
          updatedLowData[i] = FlSpot(i.toDouble() + 0.5, roundedTempY);
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
  final Function(String) onTimeSelected;

  _LineChart({
    required this.isShowingMainData,
    required this.isConfigHighData,
    required this.isConfigLowData,
    required this.lowData,
    required this.highData,
    required this.onPanUpdate,
    required this.onTimeSelected,
  });

  @override
  State<_LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<_LineChart> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (widget.isShowingMainData) {
          updateSelectedTime(details);
        } else {
          widget.onPanUpdate!(details);
        }
      },
      child: widget.isShowingMainData
          ? LineChart(
              mainChart,
              duration: const Duration(milliseconds: 0),
            )
          : LineChart(
              settingChart,
              duration: const Duration(milliseconds: 0),
            ),
    );
  }

  void updateSelectedTime(DragUpdateDetails details) {
    double coordinateX = details.globalPosition.dx;
    double chartWidth = 1.sw - 100.w; // 차트의 전체 너비를 반응형으로 계산
    double intervalWidth = chartWidth / 48; // 각 간격의 너비를 계산

    for (int i = 0; i < 48; i++) {
      double timeX = 50.w + intervalWidth * i; // 시작점을 50.w로 조정
      if (coordinateX <= timeX + intervalWidth / 2 &&
          coordinateX >= timeX - intervalWidth / 2) {
        String time =
            '${(i ~/ 2).toString().padLeft(2, '0')}:${(i % 2 * 30).toString().padLeft(2, '0')}';
        widget.onTimeSelected(time);
        break;
      }
    }
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

        clipData: const FlClipData.all(),
        // 차트의 크기를 화면 크기에 맞게 조정
        betweenBarsData: [
          BetweenBarsData(
            fromIndex: 0,
            toIndex: 1,
            color: Colors.transparent,
          )
        ],
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
    final style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14.sp,
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
        reservedSize: 40.w,
      );

  /// X축 설명
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 16.sp,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('0', style: style);
        break;
      case 12:
        text = Text('6', style: style);
        break;
      case 24:
        text = Text('12', style: style);
        break;
      case 36:
        text = Text('18', style: style);
        break;
      case 48:
        text = Text('24', style: style);
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
        getTitlesWidget: bottomTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 32.h,
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

  LineChartBarData get mainHighLineChartBarData => LineChartBarData(
        isCurved: false,
        color: Colors.blueAccent,
        barWidth: 4.w,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: widget.highData,
      );

  LineChartBarData get mainLowLineChartBarData => LineChartBarData(
        isCurved: false,
        color: Colors.redAccent,
        barWidth: 4.w,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: widget.lowData,
      );

  LineChartBarData get settingHighLineChartBarData => LineChartBarData(
        isCurved: false,
        color: Colors.blueAccent.withOpacity(0.5),
        barWidth: 4.w,
        isStrokeCapRound: false,
        dotData: const FlDotData(show: false),
        aboveBarData: BarAreaData(
          show: true,
          color: Colors.blueAccent.withOpacity(0.2),
        ),
        spots: widget.highData,
      );

  LineChartBarData get settingLowLineChartBarData => LineChartBarData(
        isCurved: false,
        color: Colors.redAccent.withOpacity(0.5),
        barWidth: 4.w,
        isStrokeCapRound: false,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: Colors.redAccent.withOpacity(0.2),
        ),
        spots: widget.lowData,
      );
}
