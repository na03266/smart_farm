import 'package:flutter/material.dart';

import 'custom_date_picker.dart';
import 'custom_text_field.dart';

class TimerModalPopup extends StatefulWidget {
  final ValueChanged<DateTime> startTimeChanged;
  final ValueChanged<DateTime> endTimeChanged;

  const TimerModalPopup({
    super.key,
    required this.startTimeChanged, required this.endTimeChanged,
  });

  @override
  State<TimerModalPopup> createState() => _TimerModalPopupState();
}

class _TimerModalPopupState extends State<TimerModalPopup> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(100.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: CustomTextField(
                  label: '타이머 이름',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomDatePicker(
                    label: '시작 시간',
                    onDateTimeChanged: widget.startTimeChanged,
                  ),
                  CustomDatePicker(
                    label: '종료 시간',
                    onDateTimeChanged: widget.endTimeChanged,
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
    );
  }
}
