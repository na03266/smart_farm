import 'package:flutter/cupertino.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:smart_farm/consts/colors.dart';

class TimerSettingScreen extends StatefulWidget {
  const TimerSettingScreen({
    super.key,
  });

  @override
  State<TimerSettingScreen> createState() => _TimerSettingScreenState();
}

class _TimerSettingScreenState extends State<TimerSettingScreen> {
  late final int unitCount;
  int timeSettings = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
                          timeSettings: timeSettings,
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
    );
  }

  saveTimerState() {}
}

class _Left extends StatefulWidget {
  int timeSettings = 0;
  String? timerTitleText = '';

  _Left({
    super.key,
    required this.timeSettings,
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
                      '시간 추가',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      /// 데이터베이스에 값을 추가로 생성
                      widget.timeSettings += 1;
                    });
                  },
                ),
              ),
              /// 타이머 목록
              /// 스트림 빌더로 전환
              Expanded(
                child: CustomScrollView(
                  primary: false,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: const EdgeInsets.all(10),
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
                                  borderRadius:
                                      BorderRadius.circular(10.0),
                                ),
                                backgroundColor: colors[1],
                                foregroundColor: Colors.white
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    /// 주입 받는 내용으로 바꿀수있게 해야함.
                                    '타이머 $index',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),

                              ///시간 세팅 모달 전환
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
          borderRadius: BorderRadius.circular(10), // 가장자리 둥글게 처리
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
    );
  }
}

class _TimeSetting extends StatefulWidget {
  final int index;

  const _TimeSetting({
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
                          border: const OutlineInputBorder(),
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
                    child: const Text('완료'),
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
