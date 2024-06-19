import 'package:flutter/material.dart';

import 'custom_date_picker.dart';
import 'custom_text_field.dart';

class TimerModalPopup extends StatelessWidget {
  final ValueChanged<DateTime> startTimeChanged;
  final ValueChanged<DateTime> endTimeChanged;
  final DateTime startTime;
  final DateTime endTime;
  final GlobalKey<FormState> formKey = GlobalKey();

  TimerModalPopup({
    super.key,
    required this.startTimeChanged,
    required this.endTimeChanged,
    required this.startTime,
    required this.endTime,
  });


  @override
  Widget build(BuildContext context) {
    String? name;
    DateTime? startTime;
    DateTime? endTime;

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(100.0),
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
                    onSaved: (String? newValue) {
                      print(newValue);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomDatePicker(
                      label: '시작 시간',
                      onDateTimeChanged: startTimeChanged,
                      initialTime: startTime,
                    ),
                    CustomDatePicker(
                      label: '종료 시간',
                      onDateTimeChanged: endTimeChanged,
                      initialTime: endTime,
                    ),
                    Column(
                      children: [
                        OutlinedButton(
                          onPressed: () {},
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
  onTimerNameSaved(String? val){
    if(val == null){
      return;
    }
    formKey.currentState!.save();
  }

}
