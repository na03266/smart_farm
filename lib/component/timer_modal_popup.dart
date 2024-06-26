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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          SizedBox(
                            height: 320,
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('타이머 목록',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 16,
                                      decoration: TextDecoration.none,
                                    )),
                                Expanded(
                                    child: ListView.separated(
                                  itemCount: timerList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Row(
                                      children: [
                                        Text(
                                          '${timerList[index][0].hour.toString().padLeft(2, '0')}:${timerList[index][0].minute.toString().padLeft(2, '0')} ~ ',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          '${timerList[index][1].hour.toString().padLeft(2, '0')}:${timerList[index][1].minute.toString().padLeft(2, '0')}',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            timerList.remove(timerList[index]);
                                            print(timerList);
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.red,
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(height: 1);
                                  },
                                ))
                              ],
                            ),
                          ),

                          /// 버튼 컬럼
                          Column(
                            children: [
                              OutlinedButton(
                                onPressed: updateTimerList,
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

  void showErrorDialog(String message) {
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('오류!'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  updateTimerList() {
    /// 타이머 값 초기화
    timerValue = "";
    for (int i = 0; i < 1440; i++) {
      timerValue = "${timerValue}0";
    }

    /// 타이머 문자열 리스트 화

    final startMin = widget.startTime!.hour * 60 + widget.startTime!.minute;
    final endMin = widget.endTime!.hour * 60 + widget.endTime!.minute;

    final condition = startMin == endMin;

    /// 시간 값 동일 시 에러 처리
    if (!condition) {
      List<DateTime> subTimer = [widget.startTime!, widget.endTime!];
      timerList.add(subTimer);
    } else {
      showErrorDialog('시작과 종료의 시간이 같습니다!');
    }

    /// 이미 인덱스가 1이면 애러 창 표현
    for (List<DateTime> tempTimer in timerList) {
      List<String> tempTimerList = timerValue.split("");
      int tempStartMin = tempTimer[0].hour * 60 + tempTimer[0].minute;
      int tempEndMin = tempTimer[1].hour * 60 + tempTimer[1].minute;

      /// 시작이 종료 보다 작을 때
      if (tempStartMin < tempEndMin) {
        /// 사이 시간 1로 채우기
        for (int i = startMin; i < endMin; i++) {
          if (tempTimerList[i] != '1') {
            tempTimerList[i] = '1';
            timerValue = tempTimerList.join('');
          } else {
            timerList.remove(tempTimer);
            showErrorDialog('시간이 겹치지 않도록 설정 해주세요!');
            return;
          }
        }
      } else {
        /// 시작 시간 뒷부분 1로 채우기
        for (int i = startMin; i < 1440; i++) {
          if (tempTimerList[i] != '1') {
            tempTimerList[i] = '1';
            timerValue = tempTimerList.join('');
          } else {
            timerList.remove(tempTimer);
            showErrorDialog('시간이 겹치지 않도록 설정 해주세요!');
            return;
          }
        }

        /// 종료 시간 앞부분 1로 채우기
        for (int i = endMin; i > 0; i--) {
          if (tempTimerList[i] != '1') {
            tempTimerList[i] = '1';
            timerValue = tempTimerList.join('');
          } else {
            timerList.remove(tempTimer);
            showErrorDialog('시간이 겹치지 않도록 설정 해주세요!');
            return;
          }
        }
      }
      setState(() {});
    }
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
