import 'package:flutter/cupertino.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/database/drift.dart';
import 'package:smart_farm/model/timer_table.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: colors[2],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Scaffold(
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
                            onTap: onTimerCardTap,
                            onPressed: onTimerPlusTap,
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: _Right(
                            activatedUnit: [
                              0,
                              1,
                              0,
                              1,
                              1,
                              0,
                              1,
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
                            //timer[selectedCard - 1].activatedUnit,
                            onTap: onUnitTap,
                          ),
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

  onTimerPlusTap() async {
    final database = GetIt.I<AppDatabase>();
    final timerStream = database.getTimers();
    var timers = [];

    /// 스트림의 경우 최초에 널 값을 던지기 때문에
    /// 한번 불러 오는 작업을 거쳐야 함.
    await for (var timerList in timerStream) {
      timers = timerList;
      break; // 스트림에서 첫 번째 데이터 목록을 가져온 후 종료합니다.
    }

    if (16 > timers.length) {
      await showCupertinoModalPopup<TimerTable>(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return TimerModalPopup(
            initStartTime: DateTime.now(),
            initEndTime: DateTime.now(),
            initName: timers.length,
          );
        },
      );
    } else {
      /// 타이머 16개 초과 시
      showDialog(
        context: context,
        builder: (dialogContext) => Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
          child: AlertDialog(
            content: const Text(
              "타이머는 16개를 초과할 수 없습니다.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              TextButton(
                child: const Text(
                  "확인",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(dialogContext, false);
                },
              ),
            ],
          ),
        ),
      );
    }
  }

  ///
  onUnitTap(int index) {
    // setState(() {
    //   timer[selectedCard - 1].activatedUnit[index] =
    //       timer[selectedCard - 1].activatedUnit[index] == 1 ? 0 : 1;
    // });
  }

  /// 전체 저장 버튼(메뉴)
  saveTimerState() {
    Navigator.of(context).pop();
  }

  /// Timer 카드 누르면 할당된 유닛 들을 보여 주는 함수
  onTimerCardTap(int index) {
    setState(() {
      selectedCard = index;
    });
  }
}

typedef OnCardSelected = void Function(int index);

class _Left extends StatefulWidget {
  final int selectedCard;
  final OnCardSelected onTap;
  final VoidCallback onPressed;

  const _Left({
    super.key,
    required this.selectedCard,
    required this.onTap,
    required this.onPressed,
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
                  onPressed: widget.onPressed,
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
                ),
              ),

              /// 타이머 목록
              /// 스트림 빌더로 전환
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
                  child: StreamBuilder<List<TimerTableData>>(
                      stream: GetIt.I<AppDatabase>().getTimers(),
                      builder: (context, snapshot) {
                        /// 에러 있을 시
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              snapshot.error.toString(),
                            ),
                          );
                        }

                        /// 값이 없고 로딩 중일 경우
                        if (snapshot.data == null) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }
                        final timers = snapshot.data!.toList();

                        return ListView.separated(
                          itemCount: timers.length,
                          itemBuilder: (BuildContext context, int index) {
                            final timer = timers[index];
                            return Dismissible(
                              key: ObjectKey(timer.id),
                              direction: DismissDirection.endToStart,
                              onDismissed: (DismissDirection direction) {
                                GetIt.I<AppDatabase>().removeTimer(timer.id);
                              },
                              child: TimerCard(
                                id: timer.id,
                                startTime: timer.startTime,
                                endTime: timer.endTime,
                                timerName: timer.timerName,
                                selectedCard: index == widget.selectedCard,
                                onTap: () {
                                  widget.onTap(index);
                                },
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 8.0);
                          },
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

typedef OnUnitTap = void Function(int index);

class _Right extends StatefulWidget {
  final List<int> activatedUnit;
  final OnUnitTap onTap;

  const _Right({
    super.key,
    required this.activatedUnit,
    required this.onTap,
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // 각 항목의 너비를 고정
                        mainAxisSpacing: 8.0, // 세로 간격
                        crossAxisSpacing: 8.0, // 가로 간격
                        childAspectRatio: 16 / 9,
                      ),
                      itemCount: widget.activatedUnit.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            widget.onTap(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: widget.activatedUnit[index] == 1
                                  ? Border.all(width: 2, color: Colors.white)
                                  : null,
                              color: widget.activatedUnit[index] == 1
                                  ? colors[3]
                                  : colors[1],
                            ),
                            child: Center(
                              child: Text(
                                'Units ${index + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                ),
                              ),
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
