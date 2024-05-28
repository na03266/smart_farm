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
  double _currentSliderValue = 20;
  late final int unitCount;

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
            Container(
              child: Padding(
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
            ),

            ///좌 설정 카드
            Expanded(
              child: Container(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '개별 전원',
                                  style: TextStyle(
                                    color: colors[6],
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Container(
                                  height: 4,
                                  width: 200,
                                  color: Color(0xff22534d),
                                ),
                                Expanded(
                                  child: CustomScrollView(
                                    primary: false,
                                    slivers: <Widget>[
                                      SliverPadding(
                                        padding: EdgeInsets.all(20),
                                        sliver: SliverGrid.count(
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          crossAxisCount: 2,
                                          children: List.generate(10, (index) {
                                            return ElevatedButton(
                                              onPressed: () {
                                                print('Button $index pressed');
                                              },
                                              child: Text(''),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Slider(
                                activeColor: colors[8],
                                inactiveColor: colors[9],
                                value: _currentSliderValue,
                                max: 50,
                                onChanged: (double value) {
                                  print(_currentSliderValue);
                                  setState(() {
                                    _currentSliderValue = value;
                                  });
                                },
                              ),
                              Slider(
                                value: _currentSliderValue,
                                max: 50,
                                onChanged: (double value) {
                                  setState(() {
                                    _currentSliderValue = value;
                                  });
                                },
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.timelapse_outlined),
                                    Text(
                                      "data",
                                    ),
                                    Text("오전/후"),
                                    Text("시간"),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      flex: 5,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
