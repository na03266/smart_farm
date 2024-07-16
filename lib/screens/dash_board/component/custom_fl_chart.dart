import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomFlChart extends StatefulWidget {
  final Color color;
  final Function(double) onTooltipShow; // 여기를 double로 변경
  final double max;
  final double min;
  final List<FlSpot> data;
  final int sensorChannel;

  const CustomFlChart({
    super.key,
    required this.color,
    required this.onTooltipShow,
    required this.max,
    required this.min,
    required this.data,
    required this.sensorChannel,
  });

  @override
  State<CustomFlChart> createState() => _CustomFlChartState();
}

class _CustomFlChartState extends State<CustomFlChart> {
  List<LineBarSpot> touchedSpots = [];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 18,
          left: 12,
          top: 24,
          bottom: 12,
        ),
        child: LineChart(
          mainData(),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white.withOpacity(0.4),
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('00:00', style: style);
        break;

      case 6:
        text = Text('03:00', style: style);
        break;

      case 12:
        text = Text('06:00', style: style);
        break;

      case 18:
        text = Text('09:00', style: style);
        break;

      case 24:
        text = Text('12:00', style: style);
        break;

      case 30:
        text = Text('15:00', style: style);
        break;

      case 36:
        text = Text('18:00', style: style);
        break;

      case 42:
        text = Text('21:00', style: style);
        break;

      case 48:
        text = Text('24:00', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      fontWeight: FontWeight.bold,
      color: widget.color.withOpacity(0.8),
      fontSize: 16,
    );

    // value 는 인터벌
    List<int> index = List.generate(20, (int index) => index);

    int offset = quarter();

    // 5의 배수에 offset을 더한 값만 표시
    /// 0, 6
    /// 1,7
    /// 2,4
    /// 3
    /// 5,8
    // 이게 트루?
    for (int i in index) {
      if (value == widget.max / 100 * 5 * index[i] + offset) {
        return Center(
          child: Text(
            '${value.toInt()}',
            style: style,
          ),
        );
      }
    }
    return const SizedBox(); // 조건에 맞지 않으면 빈 위젯 반환

  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
          if (touchResponse?.lineBarSpots != null &&
              touchResponse!.lineBarSpots!.isNotEmpty) {
            if (event is FlPanStartEvent ||
                event is FlPanUpdateEvent ||
                event is FlLongPressStart ||
                event is FlLongPressMoveUpdate ||
                event is FlTapDownEvent) {
              widget.onTooltipShow(touchResponse.lineBarSpots!.first.x);
            }
          }
        },
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((LineBarSpot touchedSpot) {
              return null; // 빈 툴팁 반환
            }).toList();
          },
        ),
        handleBuiltInTouches: true,
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((spotIndex) {
            return const TouchedSpotIndicatorData(
              FlLine(
                color: Colors.white,
                strokeWidth: 2,
                dashArray: [5, 5], // 점선으로 표시 (선택사항)
              ),
              FlDotData(
                show: false,
              ),
            );
          }).toList();
        },

        /// 선을 그래프의 최대 높이까지 연장
        getTouchLineEnd: (_, maxY) => widget.max,
      ),
      gridData: const FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50, // 필요하다면 크기 증가
            interval: (widget.max) / 100,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
      ),

      ///차트 테두리
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.white),
      ),
      minX: 0,
      maxX: 48,
      minY: widget.min,
      maxY: widget.max,
      lineBarsData: [
        LineChartBarData(
          spots: widget.data,
          isCurved: true,
          color: widget.color,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
          ),
        ),
      ],
    );
  }

  int quarter() {
    // chartIndex에 따라 다른 로직 적용
    switch (widget.sensorChannel) {
      case 0:
      case 6:
        return 0;
      case 1:
      case 7:
        return 1;
      case 2:
      case 4:
        return 2;

      case 5:
      case 8:
        return 3;
      default:
        return 4;
    }
  }
}
