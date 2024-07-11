import 'package:flutter/material.dart';
import 'package:smart_farm/consts/colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  final String sensorName;
  final double sensorValue;
  final double percent;

  const CustomProgressIndicator(
      {super.key,
      required this.sensorName,
      required this.sensorValue,
      required this.percent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sensorName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '$sensorValue',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                value: percent,
                backgroundColor: colors[1],
                color: Colors.white.withOpacity(0.5),
                minHeight: 8,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
