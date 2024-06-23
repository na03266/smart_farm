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
  })  : startTime = initStartTime,
        endTime = initEndTime;

  @override
  State<TimerModalPopup> createState() => _TimerModalPopupState();
}

class _TimerModalPopupState extends State<TimerModalPopup> {
  final GlobalKey<FormState> formKey = GlobalKey();

  String? timerName;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.id == null
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
        });
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
          startTime: Value(widget.startTime!),
          endTime: Value(widget.endTime!),
          timerName: Value(timerName!),
          activatedUnit: const Value("0000000000000000"),
        ),
      );
    } else {
      await database.updateTimerById(
        widget.id!,
        TimerTableCompanion(
          startTime: Value(widget.startTime!),
          endTime: Value(widget.endTime!),
          timerName: Value(timerName!),
          activatedUnit:  Value("0000000000000000"),
        ),
      );
    }

    Navigator.of(context).pop();
  }
}
