import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/model/sensor_value_data_model.dart';
import 'package:smart_farm/provider/data_provider.dart';
import 'package:smart_farm/provider/sensor_info.dart';
import 'package:smart_farm/screens/dash_board/component/custom_fl_chart.dart';
import 'package:smart_farm/screens/dash_board/component/custom_progress_indicator.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors[2],
        body: const Row(
          children: [
            Expanded(
              flex: 3,
              child: _Left(),
            ),
            Expanded(
              child: _Right(),
            ),
          ],
        ));
  }
}

/// 온도 0
/// 습도 1
/// 대기압 2
/// 이산화탄소 3
/// 토양 온도
/// 토양 습도
/// 전기 전도도 ec
/// ph 산성도
/// 조도

class _Left extends StatefulWidget {
  const _Left({super.key});

  @override
  State<_Left> createState() => _LeftState();
}

class _LeftState extends State<_Left> {
  List<LineBarSpot>? currentTooltipSpots;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          List<SensorInfo> sensorsInfo = dataProvider.sensors!;
          List<SensorInfo> reGeneratedList =
              sensorsInfo.where((e) => e.isSelected == true).toList();
          return Stack(
            children: <Widget>[
              ...reGeneratedList.map(
                (e) => CustomFlChart(
                  color: e.color,
                  onTooltipShow: (spots) => _updateTooltipSpots(spots),
                  max: e.max,
                  min: e.min,
                  data: [
                    /// DB에서 값 불러와서 저장하기
                  ],
                ),
              ),
              if (currentTooltipSpots != null)
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black.withOpacity(0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...reGeneratedList.map(
                          (e) => Text(
                              '${e.sensorName}: ${(currentTooltipSpots![0].y - 1).toStringAsFixed(2)}',
                              style: TextStyle(color: e.color)),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _updateTooltipSpots(List<LineBarSpot> spots) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        currentTooltipSpots = spots;
      });
    });
  }
}

class _Right extends StatelessWidget {
  const _Right({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        List<SensorValue> sensorValues =
            dataProvider.sensorValueData!.sensorValue;
        List<SensorInfo> sensorInfo = dataProvider.sensors!;
        return ListView.builder(
          itemCount: sensorValues.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: sensorInfo[index].isSelected,
                  onChanged: (bool? value) {
                    sensorInfo[index].isSelected = value ?? false;
                    dataProvider.updateSensorInfo(sensorInfo);
                  },
                  activeColor: sensorInfo[index].color,
                  checkColor: sensorInfo[index].color == Colors.white
                      ? Colors.black
                      : null,
                  hoverColor: Colors.white,
                ),
                Expanded(
                  child: CustomProgressIndicator(
                    sensorName: sensorInfo[index].sensorName,
                    sensorValue: sensorValues[index].sensorValue,
                    percent: normalize(
                      sensorValues[index].sensorValue,
                      sensorInfo[index].min,
                      sensorInfo[index].max,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  double normalize(double value, double min, double max) {
    /// 최소값과 최대값이 동일한 경우
    if (min == max) {
      return 0.0;
    }

    /// 값이 범위를 벗어난 경우 가까운 값으로 조정
    if (value < min) {
      value = min;
    } else if (value > max) {
      value = max;
    }

    return (value - min) / (max - min);
  }
}
