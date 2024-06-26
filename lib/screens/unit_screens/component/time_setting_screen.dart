import 'package:drift/drift.dart' hide Column;
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
  int selectedTimerCardId = 0;

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
              ),
              body: StreamBuilder<List<TimerTableData>>(
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

                    /// 일단 추가되는 리스트까진 표시되어야하고, 그럼 값은 현재 타이머리스트 전체를 전달한 다음에,
                    /// 하위 위젯에서 Future빌더로 받아서 사용하는 방식으로 null 일 경우 널 표시만 해주게 바꿔야함.
                    /// 값이 없고 로딩 중일 경우
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }

                    final timers = snapshot.data!.toList();

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 2,
                          child: _Left(
                            selectedCard: selectedTimerCardId,
                            onTap: onTimerCardTap,
                            onPressed: onTimerPlusTap,
                            timers: timers,
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: _Right(
                            selectedTimerId: selectedTimerCardId,
                          ),
                        ),
                      ],
                    );
                  }),
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
        builder: (dialogContext) =>
            Container(
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

  /// Timer 카드 누르면 할당된 유닛 들을 보여 주는 함수
  onTimerCardTap(int selectedTimerId) {
    setState(() {
      selectedTimerCardId = selectedTimerId;
    });
  }
}

typedef OnCardSelected = void Function(int index);

class _Left extends StatefulWidget {
  final int selectedCard;
  final OnCardSelected onTap;
  final VoidCallback onPressed;
  final List<TimerTableData> timers;

  const _Left({
    super.key,
    required this.selectedCard,
    required this.onTap,
    required this.onPressed,
    required this.timers,
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
                  child: ListView.separated(
                    itemCount: widget.timers.length,
                    itemBuilder: (BuildContext context, int index) {
                      final timer = widget.timers[index];

                      return Dismissible(
                        key: ObjectKey(timer.id),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (DismissDirection direction) async {
                          bool? shouldDelete = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: const Text('삭제 하시겠습니까?'),
                                actions: [
                                  TextButton(
                                    child: const Text(
                                      "Yes",
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text(
                                      "No",
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          if (shouldDelete == true) {
                            GetIt.I<AppDatabase>().removeTimer(timer.id);
                            return true;
                          } else {
                            // Dismissible를 취소하려면 키를 새로고침하여 원래 상태로 되돌립니다.
                            setState(() {});
                            return false;
                          }
                        },
                        child: TimerCard(
                          id: timer.id,
                          timerName: timer.timerName,
                          selectedCard: widget.selectedCard == timer.id,
                          onTap: () {
                            widget.onTap(timer.id);
                          },
                        ),
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
  final int? selectedTimerId;

  const _Right({
    super.key,
    required this.selectedTimerId,
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

        /// 현재 페이지 컨펌 받기
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                /// 유닛 목록
                /// 그럼 처음 에는 값을 받는게 없을 테니 전체 목록을 띄워야 하나?
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: FutureBuilder<List<UnitTableData>>(
                        future: GetIt.I<AppDatabase>().getUnits(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting &&
                              !snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                '${snapshot.error}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            );
                          }
                          List<UnitTableData>? units = snapshot.data;

                          return GridView.builder(
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4, // 각 항목의 너비를 고정
                              mainAxisSpacing: 8.0, // 세로 간격
                              crossAxisSpacing: 8.0, // 가로 간격
                              childAspectRatio: 16 / 9,
                            ),
                            itemCount: units!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  onUnitTap(
                                      units[index], widget.selectedTimerId!);

                                  /// 탭하면 현재 적용된 타이머의 번호를 등록
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),

                                    /// 타이머의 번호가 현재 할당된 번호와 같으면
                                    border: units[index].timerId ==
                                        widget.selectedTimerId
                                        ? Border.all(
                                        width: 2, color: Colors.white)
                                        : null,
                                    color: units[index].timerId ==
                                        widget.selectedTimerId
                                        ? colors[3]
                                        : colors[1],
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${units[index].unitName} ${units[index]
                                          .unitNumber}',
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
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 적용하기 버튼
  onUnitTap(UnitTableData? unit, int selectedTimerId) async {
    final tempUnit = unit!;
    await GetIt.I<AppDatabase>().updateUnitById(
      tempUnit.id,
      UnitTableCompanion(
        unitName: Value(tempUnit.unitName),
        unitNumber: Value(tempUnit.unitNumber),
        timerId: Value(tempUnit.timerId != selectedTimerId ? selectedTimerId: null),
        updatedAt: Value(DateTime.now()),
        isOn: Value(!tempUnit.isOn),
        isAuto: Value(tempUnit.isAuto),
      ),
    );
    setState(() {});
  }
}

/// 현재는 타이머 마다 유닛 리스트
/// 하지만, 유닛 리스트 를 별도로 두고, 해당 유닛 에는 타이머 1개의 타이머 만 적용
/// 현재 조건은 타이머 만 있다. 다른 타이머 에서 해당 유닛을 선택 하면 다른 타이머 에서는 적용할 수 없어야 한다.
