import 'package:flutter/cupertino.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:smart_farm/component/custom_text_field.dart';
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
                            onTap: (int id) {
                              setState(() {
                                selectedCard = id;
                              });
                            },
                            timer: timer,
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: _Right(),
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
}

typedef OnCardSelected = void Function(int id);

class _Left extends StatefulWidget {
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
  State<_Left> createState() => _LeftState();
}

class _LeftState extends State<_Left> {
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
                    itemCount: widget.timer.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TimerCard(
                        startTime: widget.timer[index].startTime,
                        endTime: widget.timer[index].endTime,
                        content: widget.timer[index].name,
                        selectedCard:
                            widget.selectedCard == widget.timer[index].id,
                        onTap: () {
                          widget.onTap(widget.timer[index].id);
                        },
                      );
                    }, separatorBuilder: (BuildContext context, int index) {
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
  const _Right({super.key});

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
          child: CustomScrollView(
            primary: false,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid.count(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 4,
                  children: List.generate(7, (index) {
                    return SizedBox(
                      height: 20,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // 버튼의 모양 설정
                          ),
                          backgroundColor: colors[1], // 버튼의 배경색 설정
                        ),
                        child: Text(
                          '번호',
                          style: TextStyle(
                            color: colors[6],
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeSetting extends StatelessWidget {
  _TimeSetting({
    super.key,
  });

  String titleCustomText = '';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 700,
        height: 600,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Expanded(
                    child: CustomTextField(label: '타이머 이름'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('완료'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: [
                      Text(
                        '시작 시간',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
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
                          onDateTimeChanged: (DateTime time) {
                            print("Left: $time");
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '종료 시간',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
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
                          onDateTimeChanged: (DateTime time) {
                            print("Right: $time");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
