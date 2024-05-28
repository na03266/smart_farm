import 'package:flutter/material.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:toggle_switch/toggle_switch.dart';

class UnitCard extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool condition;
  final Function(bool) onChangeCondition; // 변경된 상태를 상위 위젯으로 전달할 콜백 함수
  final OnToggle onToggle;
  final Function(String) onPressed; // 시간 제어 버튼

  const UnitCard({
    super.key,
    required this.label,
    required this.icon,
    required this.condition,
    required this.onChangeCondition, // 콜백 함수
    required this.onToggle,
    required this.onPressed, // 시간 제어 버튼
  });

  @override
  State<UnitCard> createState() => _UnitCardState();

  /// 조건에 따라 다른 색상 반환
  static UnitCardColor selectTheme(bool condition) {
    return condition ? CARDS[0] : CARDS[1];
  }
}

class _UnitCardState extends State<UnitCard> {
  late bool _condition;

  @override
  void initState() {
    super.initState();

    _condition = widget.condition;
  }

  @override
  Widget build(BuildContext context) {
    final selectedTheme = UnitCard.selectTheme(widget.condition);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: selectedTheme.bg,
      ),
      height: MediaQuery.of(context).size.height / 2 - 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),

            ///큰 아이콘과 온 오프 버튼
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  widget.icon,
                  size: 40,
                  color: selectedTheme.icon,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      ///여기서 바뀌는 값을 상위로 전달해야함,
                      _condition = !_condition;
                      widget.onChangeCondition(_condition);
                    });
                  },
                  borderRadius: BorderRadius.circular(30), // 원형 버튼을 만들기 위해 설정
                  child: Ink(
                    decoration: const ShapeDecoration(
                      shape: CircleBorder(), // 원 모양으로 설정
                    ),
                    child: Container(
                      width: 25,
                      height: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedTheme.onOff, // 배경색
                        borderRadius: BorderRadius.circular(30), // 둥근 정도 설정
                      ),
                      child: Text(
                        widget.condition ? 'ON' : 'OFF',
                        style: TextStyle(
                          color: selectedTheme.onOffFont,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          /// 아이콘 아래 글자
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 4,
            ),
            child: Text(
              widget.label,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: selectedTheme.labelFont),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 30,
              ),

              /// 시간 제어 화면 전환 버튼
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedTheme.timeControl,
                ),
                onPressed: () {
                  widget.onPressed(widget.label);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      '시간 설정',
                      style: TextStyle(
                        color: selectedTheme.timeControlFont,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 8,
              ),
              ToggleSwitch(
                minWidth: 80.0,
                borderColor: const [Colors.black],
                borderWidth: 0.4,
                cornerRadius: 20.0,
                activeBgColors: [
                  [selectedTheme.manual],
                  [selectedTheme.manual]
                ],
                activeFgColor: Colors.white,
                inactiveBgColor: selectedTheme.auto,
                inactiveFgColor: selectedTheme.autoFont,
                initialLabelIndex: 1,
                totalSwitches: 2,
                labels: const ['자동', '수동'],
                radiusStyle: true,
                onToggle: widget.onToggle,
              ),
            ],
          )
        ],
      ),
    );
  }
}
