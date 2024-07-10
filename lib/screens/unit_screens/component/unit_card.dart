import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_farm/component/each_unit_control_modal_popup.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:toggle_switch/toggle_switch.dart';

class UnitCard extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool condition;
  final UnitCardColor selectedTheme;
  final VoidCallback onPressed;
  final OnToggle? onToggle;
  final int isAuto;
  final List<int> setChannel;

  const UnitCard({
    super.key,
    required this.label,
    required this.icon,
    required this.condition,
    required this.selectedTheme,
    required this.onPressed,
    required this.onToggle,
    required this.isAuto,
    required this.setChannel,
  });

  @override
  State<UnitCard> createState() => _UnitCardState();
}

class _UnitCardState extends State<UnitCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.selectedTheme.bg,
      ),
      height: MediaQuery.of(context).size.height / 2 - 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),

            /// 카드 최상단 아이콘,온오프 버튼
            child: _CardTop(
              icon: widget.icon,
              isOnTheme: widget.selectedTheme,
              condition: widget.condition,
              onPressed: widget.onPressed,
              label: widget.label,
            ),
          ),

          /// 아이콘 아래 글자
          _CardLabel(label: widget.label, isOnTheme: widget.selectedTheme),

          ///공백
          const SizedBox(height: 8),

          /// 개별 제어 버튼
          widget.setChannel.length > 1
              ? _EachControlButton(
                  isOnTheme: widget.selectedTheme,
                  setChannel: widget.setChannel,
                )
              : const SizedBox(height: 50),

          /// 자동 수동 버튼
          _IsAutoButton(
            isOnTheme: widget.selectedTheme,
            isAuto: widget.isAuto,
            onToggle: widget.onToggle,
          ),
        ],
      ),
    );
  }
}

class _CardTop extends StatefulWidget {
  final String label;
  final IconData icon;
  final UnitCardColor isOnTheme;
  final bool condition;
  final VoidCallback? onPressed; // 변경된 상태를 상위 위젯으로 전달할 콜백 함수

  const _CardTop({
    super.key,
    required this.icon,
    required this.isOnTheme,
    required this.condition,
    required this.onPressed,
    required this.label,
  });

  @override
  State<_CardTop> createState() => _CardTopState();
}

class _CardTopState extends State<_CardTop> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          widget.icon,
          size: 48,
          color: widget.isOnTheme.icon,
        ),
        TextButton(
          onPressed: widget.onPressed,
          // 원형 버튼을 만들기 위해 설정
          style: TextButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: widget.isOnTheme.onOff),
          child: Text(
            widget.label == '차광막'
                ? widget.condition
                    ? '열림'
                    : '닫힘'
                : widget.condition
                    ? '켜짐'
                    : '꺼짐',
            style: TextStyle(
              color: widget.isOnTheme.onOffFont,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}

class _CardLabel extends StatelessWidget {
  final String label;
  final UnitCardColor isOnTheme;

  const _CardLabel({super.key, required this.label, required this.isOnTheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 4,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: isOnTheme.labelFont,
        ),
      ),
    );
  }
}

class _EachControlButton extends StatelessWidget {
  final UnitCardColor isOnTheme;
  final List<int> setChannel;

  const _EachControlButton({
    super.key,
    required this.isOnTheme,
    required this.setChannel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isOnTheme.timeControl,
          ),
          onPressed: () async {
            await showCupertinoModalPopup(
              barrierDismissible: true,
              context: context,
              builder: (_) {
                return EachUnitControlModalPopup(setChannel: setChannel);
              },
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.settings_input_component_outlined,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                '개별 제어',
                style: TextStyle(
                  color: isOnTheme.timeControlFont,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _IsAutoButton extends StatelessWidget {
  final UnitCardColor isOnTheme;
  final OnToggle? onToggle;
  final int isAuto;

  const _IsAutoButton({
    super.key,
    required this.isOnTheme,
    required this.onToggle,
    required this.isAuto,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
            [isOnTheme.manual],
            [isOnTheme.manual]
          ],
          activeFgColor: Colors.white,
          inactiveBgColor: isOnTheme.auto,
          inactiveFgColor: isOnTheme.autoFont,
          initialLabelIndex: isAuto,
          totalSwitches: 2,
          labels: const ['수동', '자동'],
          radiusStyle: true,
          onToggle: onToggle,
        ),
      ],
    );
  }
}
