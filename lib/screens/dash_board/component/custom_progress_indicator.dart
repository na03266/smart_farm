import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      padding:  EdgeInsets.only(right: 16.0.w, top: 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sensorName,
                  style:  TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                 SizedBox(width: 5.w ),
                Text(
                  sensorValue.toStringAsFixed(1),
                  style:  TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
           SizedBox(height: 8.h),
          Center(
            child: SizedBox(
              width: 200.w  ,
              child: LinearProgressIndicator(
                value: percent,
                backgroundColor: colors[1],
                color: Colors.white.withOpacity(0.5),
                minHeight: 8.h,
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
          )
        ],
      ),
    );
  }
}
