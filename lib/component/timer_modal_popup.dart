import 'package:flutter/material.dart';
import 'package:smart_farm/model/timer_model.dart';

import 'custom_date_picker.dart';
import 'custom_text_field.dart';

class TimerModalPopup extends StatelessWidget {
  final DateTime initStartTime;
  final DateTime initEndTime;
  final int initName;
  final GlobalKey<FormState> formKey = GlobalKey();
  String? timerName;

  DateTime? startTime;
  DateTime? endTime;

  /// 시작 종료 시간 초기값 설정
  TimerModalPopup({
    super.key,
    required this.initStartTime,
    required this.initEndTime,
    required this.initName,
  })  : startTime = initStartTime,
        endTime = initEndTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(100.0),
      child: Form(
        key: formKey,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: CustomTextField(
                    label: '타이머 이름',
                    onSaved: onNameSaved,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomDatePicker(
                      label: '시작 시간',
                      onDateTimeChanged: (DateTime value) {
                        startTime = value;
                      },
                      initialTime: initStartTime,
                    ),
                    CustomDatePicker(
                      label: '종료 시간',
                      onDateTimeChanged: (DateTime value) {
                        endTime = value;
                      },
                      initialTime: initEndTime,
                    ),
                    Column(
                      children: [
                        OutlinedButton(
                          onPressed: () => onFinishPressed(context),
                          style: OutlinedButton.styleFrom(
                              minimumSize: const Size(200, 50)),
                          child: const Text('완료'),
                        ),
                        const SizedBox(height: 30),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: OutlinedButton.styleFrom(
                              minimumSize: const Size(200, 50)),
                          child: const Text('취소'),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  onNameSaved(String? name) {
    if (name == '') {
      timerName = '${initName + 1}번';
    } else {
      timerName = name;
    }
  }

  onFinishPressed(BuildContext context) {
    formKey.currentState!.save();
    // final timer = TimerTable(
    //   startTime: startTime!,
    //   endTime: endTime!,
    //   name: timerName!,
    //   activatedUnit: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    // );
    // Navigator.of(context).pop(timer);
  }
}
