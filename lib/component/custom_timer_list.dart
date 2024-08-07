import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef RemoveTimer = void Function(int index);

class CustomTimerList extends StatefulWidget {
  final List<List<DateTime>> timerList;
  final RemoveTimer removeTimer;

  const CustomTimerList({
    super.key,
    required this.timerList,
    required this.removeTimer,
  });

  @override
  State<CustomTimerList> createState() => _CustomTimerListState();
}

class _CustomTimerListState extends State<CustomTimerList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '타이머 목록',
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
            fontSize: 16.sp,
            decoration: TextDecoration.none,
          ),
        ),
        Container(
          color: Colors.white,
          width: 200.w,
          height: 300.h,
          child: ListView.separated(
            itemCount: widget.timerList.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Text(
                    '${widget.timerList[index][0].hour.toString().padLeft(2, '0')}:${widget.timerList[index][0].minute.toString().padLeft(2, '0')} ~ ',
                    style:  TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    '${widget.timerList[index][1].hour.toString().padLeft(2, '0')}:${widget.timerList[index][1].minute.toString().padLeft(2, '0')}',
                    style:  TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.removeTimer(index);
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: Colors.red,
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return  SizedBox(height: 1.h);
            },
          ),
        ),
      ],
    );
  }
}
