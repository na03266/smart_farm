import 'package:flutter/cupertino.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/model/timer_model.dart';
import 'package:smart_farm/screens/unit_screens/component/timer_card.dart';

import '../../../component/timer_modal_popup.dart';

class TimerSettingScreen extends StatefulWidget {
  const TimerSettingScreen({
    super.key,
  });

  @override
  State<TimerSettingScreen> createState() => _TimerSettingScreenState();
}

class _TimerSettingScreenState extends State<TimerSettingScreen> {
  int selectedCard = 1;
  List<TimerModel> timer = [
    TimerModel(
      id: 1,
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      name: '1번',
      activatedUnit: [
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
      ],
    ),
    TimerModel(
      id: 2,
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      name: '2번',
      activatedUnit: [
        1,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
      ],
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: colors[2],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: colors[2],
              appBar: AppBar(
                backgroundColor: colors[2],
                foregroundColor: Colors.white,

                /// 뒤로가기
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),

                /// 제목
                title: const Text(
                  "타이머 설정",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                ),
                actions: [
                  /// 완료 버튼
                  ElevatedButton(
                    onPressed: saveTimerState,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(colors[7]),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '완료',
                        style: TextStyle(
                          color: colors[6],
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 2,
                          child: _Left(
                            selectedCard: selectedCard,
                            onTap: onCardTap,
                            timer: timer,
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: _Right(
                              activatedUnit:
                                  timer[selectedCard - 1].activatedUnit),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  saveTimerState() {
    Navigator.of(context).pop();
  }

  onCardTap(int id) {
    setState(() {
      selectedCard = id;
    });
  }
}

typedef OnCardSelected = void Function(int id);

class _Left extends StatelessWidget {
  final int selectedCard;
  final OnCardSelected onTap;
  final List<TimerModel> timer;

  const _Left({
    super.key,
    required this.selectedCard,
    required this.onTap,
    required this.timer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: colors[2],
            ),
            BoxShadow(
              offset: const Offset(1, 2),
              blurRadius: 5,
              spreadRadius: 2,
              color: colors[1],
              inset: true,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// 시간 추가 버튼
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // 버튼의 모양 설정
                    ),
                    backgroundColor: colors[3],
                    foregroundColor: Colors.white,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '타이머 추가',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  onPressed: () {
                    showCupertinoModalPopup(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) {
                        return TimerModalPopup(
                          startTimeChanged: (DateTime value) {},
                          endTimeChanged: (DateTime value) {},
                          startTime: DateTime.now(),
                          endTime: DateTime.now(),
                        );
                      },
                    );
                  },
                ),
              ),

              /// 타이머 목록
              /// 스트림 빌더로 전환
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
                  child: ListView.separated(
                    itemCount: timer.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TimerCard(
                        startTime: timer[index].startTime,
                        endTime: timer[index].endTime,
                        content: timer[index].name,
                        selectedCard: selectedCard == timer[index].id,
                        onTap: () {
                          onTap(timer[index].id);
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 8.0);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Right extends StatefulWidget {
  final List<int> activatedUnit;

  const _Right({
    super.key,
    required this.activatedUnit,
  });

  @override
  State<_Right> createState() => _RightState();
}

class _RightState extends State<_Right> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // 가장 자리 둥글게 처리
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: colors[2],
            ),
            BoxShadow(
              offset: const Offset(1, 2),
              blurRadius: 5,
              spreadRadius: 2,
              color: colors[1],
              inset: true,
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// 시간 추가 버튼
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // 버튼의 모양 설정
                      ),
                      backgroundColor: colors[3],
                      foregroundColor: Colors.white,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '현재 타이머에 적용하기',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    onPressed: () {
                      /// 누를 시 DB 갱신
                    },
                  ),
                ),

                /// 타이머 목록
                /// 스트림 빌더로 전환
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // 각 항목의 너비를 고정
                        mainAxisSpacing: 8.0, // 세로 간격
                        crossAxisSpacing: 8.0, // 가로 간격
                        childAspectRatio: 16 / 9,
                      ),
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.blue,
                          child: Center(
                            child: Text(
                              'Item $index',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
