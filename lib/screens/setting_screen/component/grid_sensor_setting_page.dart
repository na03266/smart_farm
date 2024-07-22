import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/model/set_up_data_model.dart';
import 'package:smart_farm/provider/data_provider.dart';
import 'package:smart_farm/service/socket_service.dart';

class GridSensorSettingPage extends StatelessWidget {
  GridSensorSettingPage({super.key});

  final List<String> columns = [
    '',
    'ID',
    'CH',
    'Reserved',
    'MULT',
    'OffSet',
    'EQ',
  ];

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20);
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        SetupData setupData = dataProvider.setupData!;
        List<SetupSensor> sensors = dataProvider.setupData!.setSensor;
        List<List<dynamic>> gridData = List.generate(sensors.length, (index) {
          return [
            sensors[index].sensorID,
            sensors[index].sensorCH,
            sensors[index].sensorReserved,
            sensors[index].sensorMULT,
            sensors[index].sensorOffSet,
            sensors[index].sensorEQ,
          ];
        });

        return Padding(
          padding: EdgeInsets.all(30.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 열 헤더
              Row(
                children: columns
                    .map((col) => Expanded(
                          child: Center(
                            child: Text(
                              col,
                              style: defaultTextStyle,
                            ),
                          ),
                        ))
                    .toList(),
              ),
              // 그리드
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns.length,
                    childAspectRatio: 3.5,
                  ),
                  itemCount: sensors.length * columns.length,
                  itemBuilder: (context, index) {
                    final row = index ~/ columns.length;
                    final col = index % columns.length;

                    if (col == 0) {
                      return Center(child: Text('$row', style: defaultTextStyle,));
                    } else {
                      return TextFormField(
                        initialValue: col == 6
                            ? "EQ Data"
                            : gridData[row][col - 1].toString(),
                        keyboardType: col == 4 || col == 5
                            ? TextInputType.numberWithOptions(decimal: true)
                            : TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.zero),
                          ),
                        ),
                        onChanged: (value) {
                          List<SetupSensor> updatedSensors =
                              List.from(dataProvider.setupData!.setSensor);
                          if (row >= updatedSensors.length) {
                            updatedSensors.add(SetupSensor.initialValue());
                          }
                          SetupSensor sensor = updatedSensors[row];
                          switch (col - 1) {
                            case 0:
                              sensor.sensorID = int.tryParse(value) ?? 0;
                            case 1:
                              sensor.sensorCH = int.tryParse(value) ?? 0;
                            case 2:
                              sensor.sensorReserved = int.tryParse(value) ?? 0;
                            case 3:
                              sensor.sensorMULT = double.tryParse(value) ?? 1.0;
                            case 4:
                              sensor.sensorOffSet =
                                  double.tryParse(value) ?? 0.0;
                            case 5:
                              // EQ 데이터 처리는 별도의 로직이 필요할 수 있습니다.
                              // 여기서는 간단히 문자열을 바이트로 변환합니다.
                              sensor.sensorEQ =
                                  Uint8List.fromList(value.codeUnits);
                          }
                          SetupData updatedSetupData = dataProvider.setupData!;
                          updatedSetupData.setSensor = updatedSensors;
                          dataProvider.updateSetupData(updatedSetupData);
                        },
                      );
                    }
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  SetupData renewSetup = GetIt.I<DataProvider>().setupData!;

                  GetIt.I<SocketService>().sendSetupData(renewSetup);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('적용되었습니다'),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0.r),
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all(colors[2]),
                  backgroundColor: WidgetStateProperty.all(colors[1]),
                  padding: WidgetStateProperty.all(
                     EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                  ),
                ),
                child:  Text(
                  '적용하기',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
