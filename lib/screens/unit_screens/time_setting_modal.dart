import 'package:flutter/cupertino.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/consts/units.dart';

class TimeSettingModal extends StatefulWidget {
  final String label;

  /// Unit Model 수정해야함.
  const TimeSettingModal({
    super.key,
    required this.label,
  });

  @override
  State<TimeSettingModal> createState() => _TimeSettingModalState();
}

class _TimeSettingModalState extends State<TimeSettingModal> {
  late final int unitCount;
  int timeSettings = 4;

  @override
  Widget build(BuildContext context) {
    final unit = UNITS.where((e) => e.label == widget.label);

    return Scaffold(
      backgroundColor: colors[2],
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ///제목 바, 완료 버튼
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                        color: colors[6],
                        fontSize: 32,
                        fontWeight: FontWeight.w700),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        elevation: WidgetStateProperty.all(10), // 그림자 높이 설정
                        backgroundColor: WidgetStateProperty.all(colors[7])),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '완료',
                        style: TextStyle(
                          color: colors[6],
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///좌 설정 카드
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(15), // 가장자리 둥글게 처리
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: colors[2],
                            ),
                            BoxShadow(
                              offset: Offset(1, 2),
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
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // 버튼의 모양 설정
                                    ),
                                    backgroundColor: colors[3], // 버튼의 배경색 설정
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '시간 추가',
                                      style: TextStyle(
                                        color: colors[6],
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      /// 값을 전달하고, 내용을 전달 받는 부분 추가 필요
                                      timeSettings += 1;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: CustomScrollView(
                                  primary: false,
                                  slivers: <Widget>[
                                    SliverPadding(
                                      padding: EdgeInsets.all(10),
                                      sliver: SliverGrid.count(
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 20,
                                        childAspectRatio: 2.5,
                                        crossAxisCount: 1,
                                        children: List.generate(timeSettings,
                                            (index) {
                                          return SizedBox(
                                            height: 20,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0), // 버튼의 모양 설정
                                                ),
                                                backgroundColor:
                                                    colors[1], // 버튼의 배경색 설정
                                              ),
                                              child: Text(
                                                '시간',
                                                style: TextStyle(
                                                  color: colors[6],
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              onPressed: () {
                                                showCupertinoDialog(
                                                  context: context,
                                                  barrierDismissible: true,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            color: Colors.white,
                                                            width: 400,
                                                            child:
                                                                CupertinoDatePicker(
                                                              mode:
                                                                  CupertinoDatePickerMode
                                                                      .time,
                                                              onDateTimeChanged:
                                                                  (DateTime
                                                                      time) {
                                                                print(time);
                                                              },
                                                            ),
                                                          ),
                                                          Container(
                                                            color: Colors.white,
                                                            width: 400,
                                                            child:
                                                                CupertinoDatePicker(
                                                              mode:
                                                                  CupertinoDatePickerMode
                                                                      .time,
                                                              onDateTimeChanged:
                                                                  (DateTime
                                                                      time) {
                                                                print(time);
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          );
                                        }),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    flex: 2,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(10), // 가장자리 둥글게 처리
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: colors[2],
                            ),
                            BoxShadow(
                              offset: Offset(1, 2),
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
                                padding: EdgeInsets.all(20),
                                sliver: SliverGrid.count(
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 20,
                                  crossAxisCount: 4,
                                  children: List.generate(7, (index) {
                                    return SizedBox(
                                      height: 20,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10.0), // 버튼의 모양 설정
                                          ),
                                          backgroundColor:
                                              colors[1], // 버튼의 배경색 설정
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
                    ),
                    flex: 5,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
