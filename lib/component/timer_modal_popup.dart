import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_farm/database/drift.dart';

import 'custom_date_picker.dart';
import 'custom_text_field.dart';

class TimerModalPopup extends StatefulWidget {
  final int? id;
  final DateTime? initStartTime;
  final DateTime? initEndTime;
  final int? initName;
  DateTime? startTime;
  DateTime? endTime;

  /// 시작 종료 시간 초기값 설정
  TimerModalPopup({
    super.key,
    this.initStartTime,
    this.initEndTime,
    this.initName,
    this.id,
  })  : startTime = DateTime.now(),
        endTime = DateTime.now();

  @override
  State<TimerModalPopup> createState() => _TimerModalPopupState();
}

class _TimerModalPopupState extends State<TimerModalPopup> {
  final GlobalKey<FormState> formKey = GlobalKey();

  String? timerName;
  String timerValue = "";
  List<List<DateTime>> timerList = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.id == null
            ? null
            : GetIt.I<AppDatabase>().getTimerById(widget.id!),
        builder: (context, snapshot) {
          if (widget.id != null &&
              snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }
          final data = snapshot.data;

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
                          initialValue: data?.timerName,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomDatePicker(
                            label: '시작 시간',
                            onDateTimeChanged: (DateTime value) {
                              widget.startTime = value;
                            },
                            initialTime: widget.initStartTime,
                          ),
                          CustomDatePicker(
                            label: '종료 시간',
                            onDateTimeChanged: (DateTime value) {
                              widget.endTime = value;
                            },
                            initialTime: widget.initEndTime,
                          ),

                          /// 현재 위치에 추가된 타이머 리스트와 삭제 버튼 필요

                          /// 버튼 컬럼
                          Column(
                            children: [
                              OutlinedButton(
                                onPressed: addTime,
                                style: OutlinedButton.styleFrom(
                                    minimumSize: const Size(100, 50)),
                                child: const Text('시간 추가'),
                              ),
                              const SizedBox(height: 30),
                              OutlinedButton(
                                onPressed: () => onFinishPressed(context),
                                style: OutlinedButton.styleFrom(
                                    minimumSize: const Size(100, 50)),
                                child: const Text('완료'),
                              ),
                              const SizedBox(height: 30),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: OutlinedButton.styleFrom(
                                    minimumSize: const Size(100, 50)),
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
        });
  }

  addTime() {
    /// 타이머 값 초기화
    timerValue = "";
    for (int i = 0; i < 1440; i++) {
      timerValue = "${timerValue}0";
    }

    List<DateTime> subTimer = [widget.startTime!, widget.endTime!];
    timerList.add(subTimer);

    for(List<DateTime> tempTimer in timerList){
      int startMin = tempTimer[0].hour * 60 + tempTimer[0].minute;
      int endMin = tempTimer[1].hour * 60 + tempTimer[1].minute;
      /// 배열을 돌면서 시작 시간과 종료 시간을 정수로 반환
      timerValue = timerValue.substring(0, startMin) +
          "1" * (endMin - startMin) +
          timerValue.substring(endMin);
    }
    print(timerList);
    print(timerValue);
  }

  onNameSaved(String? name) {
    if (name == '') {
      timerName = '${widget.initName! + 1}번';
    } else {
      timerName = name;
    }
  }

  onFinishPressed(BuildContext context) async {
    /// 텍스트 저장 하기
    formKey.currentState!.save();

    /// DB 가져 오기
    final database = GetIt.I<AppDatabase>();

    /// DB에 Timer 생성
    if (widget.id == null) {
      await database.createTimer(
        TimerTableCompanion(
          /// 문자열 리스트 넣기
          bookingTime: Value(timerValue),
          timerName: Value(timerName!),
          activatedUnit: const Value("0000000000000000"),
        ),
      );
    } else {
      await database.updateTimerById(
        widget.id!,
        TimerTableCompanion(
          bookingTime: Value(timerValue),
          timerName: Value(timerName!),
          activatedUnit: Value("0000000000000000"),
        ),
      );
    }

    Navigator.of(context).pop();
  }
}
