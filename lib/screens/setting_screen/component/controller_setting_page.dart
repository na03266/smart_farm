import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_farm/component/custom_text_field.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/model/set_up_data_model.dart';
import 'package:smart_farm/provider/data_provider.dart';
import 'package:smart_farm/service/socket_service.dart';

class ControllerSettingPage extends StatelessWidget {
  const ControllerSettingPage({super.key});

  /// 셋업 데이터
  @override
  Widget build(BuildContext context) {
    final List<String> controllerLabel = [
      'tempGap',
      'heatTemp',
      'iceType',
      'alarmType',
      'alarmTempH',
      'alarmTempL',
      'tel',
      'awsBit',
    ];
    SetupData setupData = GetIt.I<DataProvider>().setupData!;

    return Padding(
      padding: EdgeInsets.all(30.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 6,
                crossAxisSpacing: 50.w,
                mainAxisSpacing: 10.h,
              ),
              itemCount: controllerLabel.length,
              itemBuilder: (context, index) {
                String initialValue;
                bool isInteger = true;

                switch (index) {
                  case 0:
                    initialValue = setupData.tempGap.toString();
                    break;
                  case 1:
                    initialValue = setupData.heatTemp.toString();
                    break;
                  case 2:
                    initialValue = setupData.iceType.toString();
                    break;
                  case 3:
                    initialValue = setupData.alarmType.toString();
                    break;
                  case 4:
                    initialValue = setupData.alarmTempH.toString();
                    break;
                  case 5:
                    initialValue = setupData.alarmTempL.toString();
                    break;
                  case 6:
                    initialValue = setupData.tel.join('');
                    isInteger = false;
                    break;
                  case 7:
                    initialValue = setupData.awsBit.toString();
                    break;
                  default:
                    initialValue = '';
                }

                return CustomTextField(
                  label: controllerLabel[index],
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                    color: Colors.white,
                  ),
                  integerOnly: isInteger,
                  isRequired: false,
                  initialValue: initialValue,
                  onSaved: (String? newValue) {
                    if (newValue != null) {
                      switch (index) {
                        case 0:
                          setupData.tempGap = int.parse(newValue);
                          break;
                        case 1:
                          setupData.heatTemp = int.parse(newValue);
                          break;
                        case 2:
                          setupData.iceType = int.parse(newValue);
                          break;
                        case 3:
                          setupData.alarmType = int.parse(newValue);
                          break;
                        case 4:
                          setupData.alarmTempH = int.parse(newValue);
                          break;
                        case 5:
                          setupData.alarmTempL = int.parse(newValue);
                          break;
                        case 6:
                          setupData.tel = Uint8List.fromList(newValue
                              .split('')
                              .map((e) => int.parse(e))
                              .toList());
                          break;
                        case 7:
                          setupData.awsBit = int.parse(newValue);
                          break;
                      }
                    }
                  },
                );
              },
            ),
          ),
          TextButton(
            onPressed: () {
              GetIt.I<DataProvider>().updateSetupData(setupData);
              GetIt.I<SocketService>().sendSetupData(setupData);
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
            child: Text(
              '적용하기',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
