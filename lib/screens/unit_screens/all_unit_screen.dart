import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/consts/units.dart';
import 'package:smart_farm/screens/unit_screens/temperature_setting_modal.dart';
import 'package:smart_farm/screens/unit_screens/time_setting_modal.dart';
import 'package:smart_farm/screens/unit_screens/unit_card.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AllUnitScreen extends StatefulWidget {
  const AllUnitScreen({super.key});

  @override
  State<AllUnitScreen> createState() => _AllUnitScreenState();
}

class _AllUnitScreenState extends State<AllUnitScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        body: Column(
          children: [
            _TopBar(
              onToggle: mainOnToggle,
            ),
            Expanded(
              child: _Bottom(
                onToggle: isAutoToggle,
                onPressed: (label) {
                  unitTimeSetting(label);
                },
                floatingOnPressed: (){
                  temperatureSetting();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  mainOnToggle(int? isOn) {
    print(isOn);

    /// 0이면,모든 것을 다 끔
    /// 1이면 모든 것을 다 켬
  }

  void isAutoToggle(int? isAuto) {
    print(isAuto);
  }

  /// 상세 제어 화면
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

  /// 상세 제어 화면
  void temperatureSetting() {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 4 * 3,
            width: MediaQuery.of(context).size.width / 6 * 5,
            child: TemperatureSettingModal(
            ),
          ),
        );
      },
    );
  }
}

class _TopBar extends StatefulWidget {
  final OnToggle onToggle;

  const _TopBar({
    super.key,
    required this.onToggle,
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
              initialLabelIndex: 1,
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

class _Bottom extends StatefulWidget {
  final OnToggle onToggle;
  final Function(String) onPressed;
  final Function() floatingOnPressed;

  const _Bottom({
    super.key,
    required this.onToggle,
    required this.onPressed,
    required this.floatingOnPressed,
  });

  @override
  State<_Bottom> createState() => _BottomState();
}

class _BottomState extends State<_Bottom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        onPressed: widget.floatingOnPressed,
        heroTag: "actionButton",

        backgroundColor: colors[7],
        child: const Icon(
          Icons.device_thermostat_outlined,
          size: 50,
          color: Colors.white,
        ),
      ),
      body: Container(
        color: colors[2],

        /// 각각 유닛 카드
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
                  ...UNITS
                      .map(
                        (e) => UnitCard(
                          condition: e.status,
                          label: e.label,
                          icon: e.icon,
                          onChangeCondition: (newCondition) {
                            setState(() {
                              e.status = !e.status;
                            });
                            print(
                                'New condition for ${e.label}: $newCondition');
                          },
                          onToggle: widget.onToggle,
                          onPressed: (label) {
                            widget.onPressed(label);
                          },
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
