import 'package:drift/drift.dart' hide Column;
import 'package:flutter/cupertino.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/model/set_up_data_model.dart';
import 'package:smart_farm/provider/data_provider.dart';
import 'package:smart_farm/provider/timer_info.dart';
import 'package:smart_farm/provider/unit_info.dart';
import 'package:smart_farm/screens/unit_screens/component/timer_card.dart';
import 'package:smart_farm/screens/unit_screens/component/timer_modal_popup.dart';
import 'package:smart_farm/service/socket_service.dart';

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
                title: Text(
                  "타이머 설정",
                  style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700),
                ),
              ),
              body: Consumer<DataProvider>(
                  builder: (context, dataProvider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 2,
                      child: _Left(
                        selectedCard: selectedTimerCardId,
                        onTap: onTimerCardTap,
                        onPressed: () {
                          onTimerPlusTap(context, dataProvider);
                        },
                        data: dataProvider, // 타이머 문자열 목록?
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: _Right(
                          selectedTimerId: selectedTimerCardId,
                          data: dataProvider),
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

  String uint8ListToBinaryString(Uint8List uint8List) {
    return uint8List
        .map((byte) => byte.toRadixString(2).padLeft(8, '0'))
        .join();
  }

  onTimerPlusTap(BuildContext context, DataProvider dataProvider) async {
    List<TimerInfo> savedTimers = GetIt.I<DataProvider>().timers!;
    if (16 > savedTimers.length) {
      await showCupertinoModalPopup(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return TimerModalPopup(
            initStartTime: DateTime.now(),
            initEndTime: DateTime.now(),
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
            content:  Text(
              "타이머는 16개를 초과할 수 없습니다.",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              TextButton(
                child:  Text(
                  "확인",
                  style: TextStyle(
                    fontSize: 20.sp,
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
  final DataProvider data;

  const _Left({
    super.key,
    required this.selectedCard,
    required this.onTap,
    required this.onPressed,
    required this.data,
  });

  @override
  State<_Left> createState() => _LeftState();
}

class _LeftState extends State<_Left> {
  List<TimerInfo> loadedTimer = [];

  @override
  void initState() {
    super.initState();
    loadedTimer = GetIt.I<DataProvider>().timers!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(8.0.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              blurRadius: 5.r,
              color: colors[2],
            ),
            BoxShadow(
              offset:  Offset(1.w, 2.h),
              blurRadius: 5.r,
              spreadRadius: 2,
              color: colors[1],
              inset: true,
            ),
          ],
        ),
        child: Padding(
          padding:  EdgeInsets.all(16.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// 시간 추가 버튼
              Padding(
                padding:  EdgeInsets.all(12.0.w),
                child: ElevatedButton(
                  onPressed: widget.onPressed,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0.r), // 버튼의 모양 설정
                    ),
                    backgroundColor: colors[3],
                    foregroundColor: Colors.white,
                  ),
                  child:  Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Text(
                      '타이머 추가',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),

              /// 타이머 목록
              Expanded(
                child: Padding(
                  padding:
                       EdgeInsets.only(left: 12.0.w, right: 12.0.w, top: 12.0.h),
                  child: Consumer<DataProvider>(
                      builder: (context, dataProvider, child) {
                    loadedTimer = dataProvider.timers!;
                    return ListView.separated(
                      itemCount: loadedTimer.length,
                      itemBuilder: (BuildContext context, int index) {
                        var timer = loadedTimer[index];
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
                              dataProvider.removeTimerInfo(index);
                              await dataProvider.saveAllData();
                              return true;
                            } else {
                              setState(() {});
                              return false;
                            }
                          },
                          child: TimerCard(
                            timerId: timer.id,
                            timerName: timer.timerName,
                            selectedCard: widget.selectedCard == timer.id,
                            onTap: () {
                              widget.onTap(timer.id);
                            },
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return  SizedBox(height: 8.0.w);
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

class _Right extends StatefulWidget {
  final int? selectedTimerId;
  final DataProvider data;

  const _Right({
    super.key,
    required this.selectedTimerId,
    required this.data,
  });

  @override
  State<_Right> createState() => _RightState();
}

class _RightState extends State<_Right> {
  List<UnitInfo> mergedUnits = [];

  @override
  void initState() {
    super.initState();
    mergedUnits = GetIt.I<DataProvider>().units!;
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data.setupData!;
    List<String> labelList = [];

    for (UnitInfo unit in mergedUnits) {
      for (int i = 0; i < unit.setChannel.length; i++) {
        if (unit.setChannel.length == 1) {
          labelList.insert(unit.setChannel[i], unit.unitName);
        } else {
          labelList.insert(unit.setChannel[i], "${unit.unitName} ${i + 1}");
        }
      }
    }

    /// 가지고 있어야 하는게 유닛별
    /// 타이머 번호,
    /// 이름,
    return Padding(
      padding:  EdgeInsets.all(8.0.w ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r), // 가장 자리 둥글게 처리
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: colors[2],
            ),
            BoxShadow(
              offset:  Offset(1.w, 2.h),
              blurRadius: 5.r,
              spreadRadius: 2.r,
              color: colors[1],
              inset: true,
            ),
          ],
        ),

        /// 현재 페이지 컨펌 받기
        child: Center(
          child: Padding(
            padding:  EdgeInsets.all(16.0.w  ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),

                /// 유닛 목록
                Expanded(
                  child: Padding(
                    padding:  EdgeInsets.all(12.w),
                    child: GridView.builder(
                      gridDelegate:
                           SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // 각 항목의 너비를 고정
                        mainAxisSpacing: 8.0.h, // 세로 간격
                        crossAxisSpacing: 8.0.w, // 가로 간격
                        childAspectRatio: 16 / 9,
                      ),
                      itemCount: labelList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            /// 전송 쿼리
                            onUnitTap(index, widget.selectedTimerId!);

                            /// 탭하면 현재 적용된 타이머의 번호를 등록
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),

                              /// 타이머의 번호가 현재 할당된 번호와 같으면
                              border: data.setDevice[index].unitTimerSet ==
                                      widget.selectedTimerId
                                  ? Border.all(width: 2.w, color: Colors.white)
                                  : null,
                              color: data.setDevice[index].unitTimerSet ==
                                      widget.selectedTimerId
                                  ? colors[3]
                                  : colors[1],
                            ),
                            child: Center(
                              child: Text(
                                labelList[index],
                                style:  TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24.sp,
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

  /// 적용하기 버튼
  onUnitTap(int index, int selectedTimerId) {
    SetupData setupData = GetIt.I<DataProvider>().setupData!;

    int oldTimer = setupData.setDevice[index].unitTimerSet;

    /// 채널의 갯수가 적용된 타이머 가 없다 뜻.
    if (oldTimer == selectedTimerId) {
      setupData.setDevice[index].unitTimerSet = setupData.setDevice.length;
    } else {
      setupData.setDevice[index].unitTimerSet = selectedTimerId;
    }

    context.read<DataProvider>().updateSetupData(setupData);
    print(oldTimer);
    GetIt.I<SocketService>().sendSetupData(GetIt.I<DataProvider>().setupData!);
    print(GetIt.I<DataProvider>().setupData!.setDevice[index].unitTimerSet);
  }
}
