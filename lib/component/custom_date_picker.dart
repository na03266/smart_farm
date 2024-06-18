import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  final String label;
  final ValueChanged<DateTime> onDateTimeChanged;

  const CustomDatePicker({
    super.key,
    required this.label,
    required this.onDateTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
            fontSize: 16,
            decoration: TextDecoration.none,
          ),
        ),
        Container(
          color: Colors.white,
          width: 300,
          height: 300,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            onDateTimeChanged: onDateTimeChanged,
          ),
        ),
      ],
    );
  }
}
