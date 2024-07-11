import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomFlChart extends StatefulWidget {
  final Color color;
  final Function(List<LineBarSpot>) onTooltipShow;
  final double max;
  final double min;
  final List<FlSpot> data;

  const CustomFlChart({
    super.key,
    required this.color,
    required this.onTooltipShow,
    required this.max,
    required this.min,
    required this.data,
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

  /// y축 문자 표시
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white.withOpacity(0.4),
      fontSize: 16,
    );
    return Text('', style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (touchedSpots) {
            widget.onTooltipShow(touchedSpots);
            return touchedSpots.map((LineBarSpot touchedSpot) {}).toList();
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
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: false,
        verticalInterval: 4,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.white.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
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
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
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
}
