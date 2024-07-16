import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/database/drift.dart';
import 'package:smart_farm/model/sensor_value_data_model.dart';
import 'package:smart_farm/provider/data_provider.dart';
import 'package:smart_farm/provider/sensor_info.dart';
import 'package:smart_farm/screens/dash_board/component/custom_fl_chart.dart';
import 'package:smart_farm/screens/dash_board/component/custom_progress_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[2],
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: _Left(selectedDate: selectedDate ?? DateTime.now()),
          ),
          const Expanded(
            child: _Right(),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          DateTime? pickedDate = await showDatePicker(context);
          if (pickedDate != null) {
            print('선택된 날짜: $pickedDate');
            // 여기에서 선택된 날짜를 사용하면 됩니다.
          }
        },
        heroTag: "calenderButton",
        backgroundColor: colors[7].withOpacity(0.5),
        elevation: 0,
        child: const Icon(
          Icons.calendar_month_outlined,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  /// 여기 달력에서 데이터 전송하는 것까지.
  Future<DateTime?> showDatePicker(BuildContext context) async {
    selectedDate = await showCupertinoModalPopup<DateTime>(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        DateTime? tempPickedDate = DateTime.now();
        final defaultBoxDecoration = BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: Colors.grey[400]!, width: 1.0),
        );
        return Center(
          child: Container(
            width: 700,
            height: 450,
            color: Colors.white,
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: TableCalendar(
                        locale: 'ko_KR',
                        focusedDay: DateTime.now(),
                        firstDay: DateTime.now()
                            .subtract(const Duration(days: 365 * 2)),
                        lastDay: DateTime.now(),
                        headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            titleTextStyle: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            )),
                        calendarStyle: CalendarStyle(
                            isTodayHighlighted: true,
                            defaultDecoration: defaultBoxDecoration,
                            weekendDecoration: defaultBoxDecoration,
                            selectedDecoration: defaultBoxDecoration.copyWith(
                              border: Border.all(
                                color: colors[2],
                                width: 2.0
                              ),),
                        ),
                        onDaySelected:
                            (DateTime selectedDay, DateTime focusedDay) {
                          print(selectedDay);
                          tempPickedDate = selectedDay;
                        },
                        selectedDayPredicate: (DateTime date) {
                          if (tempPickedDate != null) {
                            return false;
                          }
                          return date.isAtSameMomentAs(tempPickedDate!.toUtc());
                        },
                      ),
                    ),
                    CupertinoButton(
                      child: const Text('확인'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    return selectedDate;
  }
}

class _Left extends StatefulWidget {
  final DateTime selectedDate;

  const _Left({super.key, required this.selectedDate});

  @override
  State<_Left> createState() => _LeftState();
}

class _LeftState extends State<_Left> {
  final ValueNotifier<double?> commonXPositionNotifier =
  ValueNotifier<double?>(null);

  @override
  void dispose() {
    commonXPositionNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        List<SensorInfo> sensorsInfo = dataProvider.sensors!;
        List<SensorInfo> reGeneratedList =
        sensorsInfo.where((e) => e.isSelected == true).toList();
        return FutureBuilder(
            future: GetIt.I<AppDatabase>()
                .getSensorDataFromLastDay(widget.selectedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.data!.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              final sensorData = snapshot.data!;

              /// 1번인덱스에는 sensorData의 temperature을 y값으로 하는 0~49번까지의 값
              List<List<FlSpot>> createdData = List.generate(9, (sensorIndex) {
                return List.generate(49, (timeIndex) {
                  if (sensorData.length > timeIndex) {
                    double x = timeIndex.toDouble();
                    double y;

                    switch (sensorIndex) {
                      case 0:
                        y = sensorData[timeIndex].temperature;
                        break;
                      case 1:
                        y = sensorData[timeIndex].humidity;
                        break;
                      case 2:
                        y = sensorData[timeIndex].pressure;
                        break;
                      case 3:
                        y = sensorData[timeIndex].lightIntensity;
                        break;
                      case 4:
                        y = sensorData[timeIndex].co2;
                        break;
                      case 5:
                        y = sensorData[timeIndex].ph;
                        break;
                      case 6:
                        y = sensorData[timeIndex].soilTemperature;
                        break;
                      case 7:
                        y = sensorData[timeIndex].soilMoisture;
                        break;
                      case 8:
                        y = sensorData[timeIndex].electricalConductivity;
                        break;
                      default:
                        y = 0;
                    }
                    return FlSpot(x, y);
                  } else {
                    // 데이터가 없는 경우 null 또는 기본값 사용
                    return FlSpot(timeIndex.toDouble(), 0);
                  }
                });
              });
              return Column(
                children: [
                  Text(
                    DateFormat('yyyy. MM. dd.').format(widget.selectedDate),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 30),
                  ),
                  Stack(
                    children: <Widget>[
                      ...reGeneratedList.map(
                            (e) =>
                            CustomFlChart(
                              color: e.color,
                              onTooltipShow: (x) {
                                commonXPositionNotifier.value = x;
                              },
                              max: e.max,
                              min: e.min,
                              data: createdData[e.setChannel],
                              sensorChannel: e.setChannel,
                            ),
                      ),
                      ValueListenableBuilder<double?>(
                        valueListenable: commonXPositionNotifier,
                        builder: (context, commonXPosition, child) {
                          if (commonXPosition == null) {
                            return const SizedBox.shrink();
                          }
                          return Positioned(
                            top: 36,
                            right: 30,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              color: Colors.black.withOpacity(0.2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: reGeneratedList.map((e) {
                                  final spot =
                                  createdData[e.setChannel].firstWhere(
                                        (spot) => spot.x == commonXPosition,
                                    orElse: () =>
                                    createdData[e.setChannel].last,
                                  );
                                  return Text(
                                    '${e.sensorName}: ${spot.y.toStringAsFixed(
                                        1)}',
                                    style: TextStyle(
                                        color: e.color,
                                        fontWeight: FontWeight.bold),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              );
            });
      },
    );
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
