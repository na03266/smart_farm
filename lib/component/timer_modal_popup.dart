import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_farm/component/custom_timer_list.dart';
import 'package:smart_farm/database/drift.dart';

import 'custom_date_picker.dart';
import 'custom_text_field.dart';

class TimerModalPopup extends StatefulWidget {
  final TimerTableData? data;
  final DateTime? initStartTime;
  final DateTime? initEndTime;
  final int? initName;

  /// 시작 종료 시간 초기값 설정
  const TimerModalPopup({
    super.key,
    this.initStartTime,
    this.initEndTime,
    this.initName,
    this.data,
  });

  @override
  State<TimerModalPopup> createState() => _TimerModalPopupState();
}

class _TimerModalPopupState extends State<TimerModalPopup> {
  final GlobalKey<FormState> formKey = GlobalKey();

  String? timerName;
  String timerValue = "";
  List<List<DateTime>> timerList = [];
  DateTime? startTime = DateTime.now();
  DateTime? endTime = DateTime.now();

  @override
  initState() {
    super.initState();
    if (widget.data != null) {
      updateTimerListFromValue();
    }
  }

  /// 처음 ID 값이 있다면 초기 값들을 세팅 하는 함수
  updateTimerListFromValue() {
    timerValue = widget.data!.bookingTime;

    DateTime now = DateTime.now();
    List<String> tempTimerList = timerValue.split("");

    List<int> tempEnabledTimerListA = [];
    List<int> tempEnabledTimerListB = [];

    /// 타이머 벨류 돌면서 1인 것 숫자로 바꾸어서 해당하는 인덱스를 넣기
    for (int i = 0; i < tempTimerList.length; i++) {
      if (tempTimerList[i] == '1' && tempTimerList[i] == tempTimerList[i + 1]) {
        tempEnabledTimerListA.add(i);
        tempEnabledTimerListB.add(i + 1);
      }
    }

    /// 합집합 구하기
    List<int> union =
        [...tempEnabledTimerListA, ...tempEnabledTimerListB].toSet().toList();

    /// 교집합 구하기
    List<int> intersection = tempEnabledTimerListA
        .toSet()
        .intersection(tempEnabledTimerListB.toSet())
        .toList();

    /// 합집합 - 교집합
    List<int> result =
        union.where((element) => !intersection.contains(element)).toList();

    ///결과 정렬
    result.sort();

    for (int i = 0; i < result.length; i += 2) {
      int startMin = result[i];
      int endMin = result[i + 1];
      DateTime startTime =
          DateTime(now.year, now.month, now.day, startMin ~/ 60, startMin % 60);
      DateTime endTime =
          DateTime(now.year, now.month, now.day, endMin ~/ 60, endMin % 60);

      List<DateTime> subTimer = [startTime, endTime];

      timerList = [...timerList, subTimer].toSet().toList();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    initialValue: widget.data?.timerName.toString(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomDatePicker(
                      label: '시작 시간',
                      onDateTimeChanged: (DateTime value) {
                        startTime = value;
                      },
                      initialTime: widget.initStartTime,
                    ),
                    CustomDatePicker(
                      label: '종료 시간',
                      onDateTimeChanged: (DateTime value) {
                        endTime = value;
                      },
                      initialTime: widget.initEndTime,
                    ),

                    /// 타이머 리스트와 삭제 버튼 필요
                    CustomTimerList(
                      timerList: timerList,
                      removeTimer: (int index) {
                        removeTimer(index);
                      },
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
    for (int i = 0; i < 1441; i++) {
      timerValue = "${timerValue}0";
    }

    /// 타이머 문자열 리스트 화
    List<String> tempTimerList = timerValue.split("");

    final startMin = startTime!.hour * 60 + startTime!.minute;
    final endMin = endTime!.hour * 60 + endTime!.minute;

    final condition = startMin == endMin;

    /// 시간 값 동일 시 에러 처리
    if (condition) {
      showErrorDialog('시작과 종료의 시간이 같습니다!');
      return;
    }

    /// 임시 타이머 목록에 추가
    List<DateTime> subTimer = [startTime!, endTime!];
    timerList.add(subTimer);

    /// 이미 인덱스가 1이면 애러 창 표현
    for (List<DateTime> tempTimer in List.from(timerList)) {
      int tempStartMin = tempTimer[0].hour * 60 + tempTimer[0].minute;
      int tempEndMin = tempTimer[1].hour * 60 + tempTimer[1].minute;

      /// 시작이 종료 보다 작을 때
      if (tempStartMin < tempEndMin) {
        /// 사이 시간 1로 채우기
        for (int i = tempStartMin; i < tempEndMin; i++) {
          if (tempTimerList[i] != '1') {
            tempTimerList[i] = '1';
          } else {
            timerList.remove(subTimer);
            showErrorDialog('시간이 겹치지 않도록 설정 해주세요!');
            return;
          }
        }
      } else {
        /// 시작 시간 뒷부분 1로 채우기
        for (int i = tempStartMin; i < 1440; i++) {
          if (tempTimerList[i] != '1') {
            tempTimerList[i] = '1';
          } else {
            timerList.remove(subTimer);
            showErrorDialog('시간이 겹치지 않도록 설정 해주세요!');
            return;
          }
        }
        /// 종료 시간 앞부분 1로 채우기
        for (int i = 0; i < tempEndMin; i++) {
          if (tempTimerList[i] != '1') {
            tempTimerList[i] = '1';
          } else {
            timerList.remove(subTimer);
            showErrorDialog('시간이 겹치지 않도록 설정 해주세요!');
            return;
          }
        }
      }
    }
    timerValue = tempTimerList.join('');
    setState(() {});
  }

  onNameSaved(String? name) {
    if (name == '') {
      timerName = '${widget.initName! + 1}번';
    } else {
      timerName = name;
    }
  }

  onFinishPressed(BuildContext context) async {
    List<String> tempTimerList = timerValue.split("");

    for (int i = 0; i < tempTimerList.length; i++) {
      tempTimerList[i] = '0';
    }
    for (List<DateTime> tempTimer in List.from(timerList)) {
      int tempStartMin = tempTimer[0].hour * 60 + tempTimer[0].minute;
      int tempEndMin = tempTimer[1].hour * 60 + tempTimer[1].minute;

      /// 시작이 종료 보다 작을 때
      if (tempStartMin < tempEndMin) {
        /// 사이 시간 1로 채우기
        for (int i = tempStartMin; i < tempEndMin; i++) {
          tempTimerList[i] = '1';
        }
      } else {
        /// 시작 시간 뒷부분 1로 채우기
        for (int i = tempStartMin; i < 1440; i++) {
          tempTimerList[i] = '0';
        }

        /// 종료 시간 앞부분 1로 채우기
        for (int i = 0; i < tempEndMin; i++) {
          tempTimerList[i] = '0';
        }
      }
    }
    timerValue = tempTimerList.join('');

    /// 텍스트 저장 하기
    formKey.currentState!.save();

    /// DB 가져 오기
    final database = GetIt.I<AppDatabase>();

    /// DB에 Timer 생성
    if (widget.data == null) {
      await database.createTimer(
        TimerTableCompanion(
          /// 문자열 리스트 넣기
          bookingTime: Value(timerValue),
          timerName: Value(timerName!),
        ),
      );
    } else {
      final timer = await database.getTimerById(widget.data!.id);
      await database.updateTimerById(
        timer.id,
        TimerTableCompanion(
          bookingTime: Value(timerValue),
          timerName: Value(timerName!),
        ),
      );
    }

    Navigator.of(context).pop();
  }

  void removeTimer(int index) {
    timerList.removeAt(index);
    print(timerList);
    setState(() {});
  }
}
