import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_farm/screens/unit_screens/component/timer_modal_popup.dart';
import 'package:smart_farm/consts/colors.dart';

class TimerCard extends StatelessWidget {
  final int timerId;
  final String timerName;
  final bool selectedCard;
  final VoidCallback onTap;

  const TimerCard({
    super.key,
    required this.timerName,
    this.selectedCard = false,
    required this.onTap,
    required this.timerId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0.r),
          border:
              selectedCard ? Border.all(color: Colors.white, width: 2.w) : null,
          color: colors[1],
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 20.h,
            bottom: 20.h,
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Text(
                    timerName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                 SizedBox(width: 24.w),
                IconButton(
                    onPressed: () async {
                      await showCupertinoModalPopup(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) {
                          return TimerModalPopup(
                            timerId: timerId,
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
