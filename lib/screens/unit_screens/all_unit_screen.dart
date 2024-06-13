import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/provider/unit_provider.dart';
import 'package:smart_farm/screens/unit_screens/time_setting_modal.dart';
import 'package:smart_farm/screens/unit_screens/unit_card.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AllUnitScreen extends StatefulWidget {
  AllUnitScreen({super.key});

  @override
  State<AllUnitScreen> createState() => _AllUnitScreenState();
}

class _AllUnitScreenState extends State<AllUnitScreen> {
  ///UNIT 의 목록중 state 가 하나라도 true 면 1 아니면 0
  int selectedIndex = UnitProvider().UNITS.any((unit) => unit.status) ? 1 : 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        body: Column(
          children: [
            _TopBar(
              onToggle: allUnitOnToggle,
              selectedIndex: selectedIndex,
            ),

            /// 토글 까지는 완료 이제 아래 유닛 카드에 값을 적용시켜야함.
            Expanded(
              child: _UnitCard(
                onPressed: (label) {
                  unitTimeSetting(label);
                },
              ),
            ),
          ],
        ),
        floatingActionButton: _FloatingButton(),
      ),
    );
  }

  void allUnitOnToggle(int? index) {
    setState(() {
      selectedIndex = index!;
      bool status = index == 1;
      UnitProvider().UNITS.map((unit) => unit.status = status);
    });
  }

  /// 개별 제어 화면
  void unitTimeSetting(String label) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 4 * 3,
            width: MediaQuery.of(context).size.width / 6 * 5,
            child: TimeSettingModal(
              label: label,
            ),
          ),
        );
      },
    );
  }
}

class _TopBar extends StatefulWidget {
  final OnToggle? onToggle;
  late int selectedIndex;

  _TopBar({
    super.key,
    required this.onToggle,
    required this.selectedIndex,
  });

  @override
  State<_TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<_TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: colors[1],
      child: Padding(
        padding: const EdgeInsets.only(
          right: 36.0,
          left: 36.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// 전원 아이콘 + 레이블 박스
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Icon(
                    Icons.power_settings_new_outlined,
                    size: 35,
                    color: colors[2],
                  ),
                  Text(
                    '  전원제어',
                    style: TextStyle(
                      fontSize: 20,
                      color: colors[6],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 30),

            ///전원 토글 스위치
            ToggleSwitch(
              minWidth: 90.0,
              borderColor: const [Colors.black],
              borderWidth: 0.4,
              cornerRadius: 20.0,
              activeBgColors: [
                [colors[2]],
                [colors[2]]
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: colors[1],
              inactiveFgColor: Colors.white,
              initialLabelIndex: widget.selectedIndex,
              totalSwitches: 2,
              labels: const ['OFF', 'ON'],
              radiusStyle: true,
              onToggle: widget.onToggle,
            ),
          ],
        ),
      ),
    );
  }
}

class _UnitCard extends StatefulWidget {
  final Function(String) onPressed;

  const _UnitCard({
    super.key,
    required this.onPressed,
  });

  @override
  State<_UnitCard> createState() => _UnitCardState();
}

class _UnitCardState extends State<_UnitCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors[2],
      child: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 5,
              children: <Widget>[
                ...UnitProvider().UNITS.map(
                      (e) => UnitCard(
                        condition: e.status,
                        label: e.label,
                        icon: e.icon,
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingButton extends StatelessWidget {
  const _FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        /// 시간 제어 화면 전환 버튼
        FloatingActionButton.large(
          onPressed: () {},
          heroTag: "timeButton",
          backgroundColor: colors[7],
          child: const Icon(
            Icons.device_thermostat_outlined,
            size: 50,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
        /// 온도 제어 화면 전환 버튼
        FloatingActionButton.large(
          onPressed: () {},
          heroTag: "tempButton",
          backgroundColor: colors[7],
          child: const Icon(
            Icons.device_thermostat_outlined,
            size: 50,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
