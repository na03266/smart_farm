import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/model/set_up_data_model.dart';
import 'package:smart_farm/provider/data_provider.dart';
import 'package:smart_farm/service/socket_service.dart';

class GridDeviceSettingPage extends StatelessWidget {
  GridDeviceSettingPage({super.key});

  final List<String> columns = [
    '',
    'Id',
    'Type',
    'CH',
    'OpenCH',
    'CloseCH',
    'MoveTime',
    'StopTime',
    'OpenTime',
    'CloseTime',
    'OPTime',
    'TimerSet',
  ];

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = TextStyle(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.sp);
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        SetupData setupData = dataProvider.setupData!;
        List<SetupDevice> device = dataProvider.setupData!.setDevice;
        List<List<int>> gridData = List.generate(device.length, (index) {
          return [
            device[index].unitId,
            device[index].unitType,
            device[index].unitCH,
            device[index].unitOpenCH,
            device[index].unitCloseCH,
            device[index].unitMoveTime,
            device[index].unitStopTime,
            device[index].unitOpenTime,
            device[index].unitCloseTime,
            device[index].unitOPTime,
            device[index].unitTimerSet,
          ];
        });

        return Padding(
          padding:  EdgeInsets.all(30.0.w),
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
                  itemCount: device.length * columns.length,
                  itemBuilder: (context, index) {
                    final row = index ~/ columns.length;
                    final col = index % columns.length;

                    if (col == 0) {
                      return Center(
                          child: Text(
                        '$row',
                        style: defaultTextStyle,
                      ));
                    } else {
                      return TextFormField(
                        initialValue: gridData[row][col - 1].toString(),
                        keyboardType: TextInputType.number,
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
                          int newValue = int.tryParse(value) ?? 0;
                          List<SetupDevice> updatedDevices =
                              List.from(dataProvider.setupData!.setDevice);
                          if (row >= updatedDevices.length) {
                            updatedDevices.add(SetupDevice(
                              unitId: 0,
                              unitType: 0,
                              unitCH: 0,
                              unitOpenCH: 0,
                              unitCloseCH: 0,
                              unitMoveTime: 0,
                              unitStopTime: 0,
                              unitOpenTime: 0,
                              unitCloseTime: 0,
                              unitOPTime: 0,
                              unitTimerSet: 0,
                            ));
                          }
                          SetupDevice device = updatedDevices[row];
                          switch (col - 1) {
                            case 0:
                              device.unitId = newValue;
                            case 1:
                              device.unitType = newValue;
                            case 2:
                              device.unitCH = newValue;
                            case 3:
                              device.unitOpenCH = newValue;
                            case 4:
                              device.unitCloseCH = newValue;
                            case 5:
                              device.unitMoveTime = newValue;
                            case 6:
                              device.unitStopTime = newValue;
                            case 7:
                              device.unitOpenTime = newValue;
                            case 8:
                              device.unitCloseTime = newValue;
                            case 9:
                              device.unitOPTime = newValue;
                            case 10:
                              device.unitTimerSet = newValue;
                          }
                          SetupData updatedSetupData = dataProvider.setupData!;
                          updatedSetupData.setDevice = updatedDevices;
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
                     EdgeInsets.symmetric(horizontal: 30.h, vertical: 15.h),
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
