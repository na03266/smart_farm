import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:interactive_slider/interactive_slider.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
  double highValue = 28;
  double lowValue = 20;
  List<_TemperatureData> data = [
    _TemperatureData(DateTime(2022, 1, 1, 0, 0), 20),
    _TemperatureData(DateTime(2022, 1, 1, 0, 30), 22),
    _TemperatureData(DateTime(2022, 1, 1, 1, 0), 21),
    _TemperatureData(DateTime(2022, 1, 1, 1, 30), 23),
    // 원하는 시간 데이터 추가
  ];
  @override
  Widget build(BuildContext context) {
    final highController = InteractiveSliderController(highValue / 50);
    final lowController = InteractiveSliderController(lowValue / 50);
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
                        offset: Offset(1, 2),
                        blurRadius: 5,
                        spreadRadius: 2,
                        color: colors[1],
                        inset: true,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SfCartesianChart(
                          primaryXAxis: DateTimeAxis(
                            intervalType: DateTimeIntervalType.minutes,
                            interval: 30,
                            // dateFormat: DateFormat.Hm(),
                            title: AxisTitle(text: '시간'),
                          ),
                          primaryYAxis: NumericAxis(
                            minimum: 10,
                            maximum: 30,
                            interval: 5,
                            title: AxisTitle(text: 'Temperature (°C)'),
                          ),
                          series: <ChartSeries>[
                            LineSeries<_TemperatureData, DateTime>(
                              dataSource: data,
                              xValueMapper: (_TemperatureData temp, _) => temp.time,
                              yValueMapper: (_TemperatureData temp, _) => temp.temperature,
                              dataLabelSettings: DataLabelSettings(isVisible: true),
                              enableTooltip: true,
                              markerSettings: MarkerSettings(
                                isVisible: true,
                                // 데이터 포인트를 드래그하여 수정 가능하게 설정
                                borderWidth: 2,
                              ),
                              // 데이터 포인트 드래그 가능하게 설정
                              onPointTap: (ChartPointDetails  details) {
                                _editTemperatureDialog(details.pointIndex!);
                              },
                            ),
                          ],
                        )
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
  void _editTemperatureDialog(int index) {
    final _TemperatureData point = data[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double newTemperature = point.temperature;
        return AlertDialog(
          title: Text("Edit Temperature"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Time: ${point.time.hour}:${point.time.minute.toString().padLeft(2, '0')}"),
              Text("Temperature: ${newTemperature.toStringAsFixed(1)}°C"),
              Slider(
                value: newTemperature,
                min: 10,
                max: 30,
                divisions: 40,
                label: newTemperature.toStringAsFixed(1),
                onChanged: (double value) {
                  setState(() {
                    newTemperature = value;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () {
                setState(() {
                  data[index] = _TemperatureData(point.time, newTemperature);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class _TemperatureData {
  _TemperatureData(this.time, this.temperature);

  final DateTime time;
  final double temperature;
}