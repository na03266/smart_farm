import 'package:flutter/cupertino.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:smart_farm/consts/colors.dart';

class TimeSettingModal extends StatefulWidget {
  final String label;

  const TimeSettingModal({
    super.key,
    required this.label,
  });

  @override
  State<TimeSettingModal> createState() => _TimeSettingModalState();
}

class _TimeSettingModalState extends State<TimeSettingModal> {
  late final int unitCount;
  int timeSettings = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colors[2],
      body: Center(
        child: ElevatedButton(
          onPressed: _showTimeSettingDialog,
          child: Text('시간 설정 열기'),
        ),
      ),
    );
  }

  void _showTimeSettingDialog() {
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 4 * 3,
              width: MediaQuery.of(context).size.width / 6 * 5,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ///제목 바, 완료 버튼
                    _Top(label: widget.label),

                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          /// 좌측 시간 설정
                          _BottomLeft(
                            timeSettings: timeSettings,
                          ),

                          /// 우측 적용 버튼 카드
                          _BottomRight(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class _Top extends StatefulWidget {
  final String label;

  const _Top({
    super.key,
    required this.label,
  });

  @override
  State<_Top> createState() => _TopState();
}

class _TopState extends State<_Top> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style: TextStyle(
                color: colors[6], fontSize: 32, fontWeight: FontWeight.w700),
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
    );
  }
}

class _BottomLeft extends StatefulWidget {
  int timeSettings = 0;
  String? timerTitleText = '';

  _BottomLeft({
    super.key,
    required this.timeSettings,
  });

  @override
  State<_BottomLeft> createState() => _BottomLeftState();
}

class _BottomLeftState extends State<_BottomLeft> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), // 가장자리 둥글게 처리
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
                        borderRadius: BorderRadius.circular(10.0), // 버튼의 모양 설정
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
                        widget.timeSettings += 1;
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
                          children: List.generate(widget.timeSettings, (index) {
                            return SizedBox(
                              height: 20,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // 버튼의 모양 설정
                                  ),
                                  backgroundColor: colors[1],
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      '타이머 $index',
                                      style: TextStyle(
                                        color: colors[6],
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),

                                ///시간 세팅화면으로 전환
                                onPressed: () {
                                  _timeSettings(index);
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
    );
  }

  void _timeSettings(int index) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: _TimeSetting(
            index: index,
          ),
        );
      },
    );
  }
}

class _BottomRight extends StatefulWidget {
  _BottomRight({super.key});

  @override
  State<_BottomRight> createState() => _BottomRightState();
}

class _BottomRightState extends State<_BottomRight> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), // 가장자리 둥글게 처리
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
      ),
      flex: 5,
    );
  }
}

class _TimeSetting extends StatefulWidget {
  final int index;

  _TimeSetting({
    super.key,
    required this.index,
  });

  @override
  State<_TimeSetting> createState() => _TimeSettingState();
}

class _TimeSettingState extends State<_TimeSetting> {
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
                  SizedBox(
                    height: 50,
                    width: 500,
                    child: Scaffold(
                      resizeToAvoidBottomInset: false, // 키보드가 올라올 때 레이아웃 유지
                      body: TextField(
                        onChanged: (String inputText) {
                          titleCustomText = inputText;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '타이머 ${widget.index}',
                          filled: true,
                        ),
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 16,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('완료'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '시작 시간',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 16,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    '종료 시간',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 16,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
