import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/database/drift.dart';
import 'package:smart_farm/model/value_model.dart';
import 'package:smart_farm/provider/data_provider.dart';
import 'package:smart_farm/provider/unit_provider.dart';
import 'package:smart_farm/screens/unit_screens/component/temperature_setting_screen.dart';
import 'package:smart_farm/screens/unit_screens/component/time_setting_screen.dart';
import 'package:smart_farm/screens/unit_screens/component/unit_card.dart';
import 'package:smart_farm/service/socket_service.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AllUnitScreen extends StatefulWidget {
  const AllUnitScreen({super.key});

  @override
  State<AllUnitScreen> createState() => _AllUnitScreenState();
}

class _AllUnitScreenState extends State<AllUnitScreen> {
  ///UNIT 의 목록중 state 가 하나라도 true 면 1 아니면 0

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        if (dataProvider.valueData == null) {
          return const Center(child: CircularProgressIndicator());
        }
        List<DeviceValue> units = dataProvider.valueData!.deviceValue;
        print(dataProvider.valueData!.deviceValue
            .map((device) =>
                'UnitId: ${device.unitId}, Status: ${device.unitStatus}, Mode: ${device.unitMode}')
            .toList());
        return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Scaffold(
              body: Column(
                children: [
                  _TopBar(
                    onToggle: (int? index) {
                      onAllUnitToAutoToggle(index, context, dataProvider);
                    },
                    selectedIndex: units.any((u) => u.unitMode == 1) ? 1 : 0,
                  ),
                  Expanded(
                    child: _UnitCard(
                      units: units,
                      onPressed: (int? selectedUnitId) {
                        onOnOffButtonPressed(
                            selectedUnitId, context, dataProvider);
                      },
                      onToggle: (int? index, int? selectedUnitId) {
                        onAutoToggle(
                            index, selectedUnitId, context, dataProvider);
                      },
                    ),
                  ),
                ],
              ),
              floatingActionButton: const _SettingButtons(),
            ));
      },
    );
  }

  ///버튼 전체 통합 제어
  Future<void> onAllUnitToAutoToggle(
      int? index, BuildContext context, DataProvider dataProvider) async {
    ValueData valueData = dataProvider.valueData!;

    /// 전체 유닛 루프 돌면서
    for (DeviceValue value in valueData.deviceValue) {
      value.unitMode = index!;
    }
    context.read<DataProvider>().updateValueData(valueData);

    GetIt.I<SocketService>().sendValueData(dataProvider.valueData!);
  }

  onAutoToggle(int? index, int? selectedUnitId, BuildContext context,
      DataProvider dataProvider) {
    ValueData valueData = dataProvider.valueData!;

    /// 온 오프 터치시 자동도 수동으로 변경
    valueData.deviceValue[selectedUnitId!].unitMode = index!;

    /// 되는지 확인 해 봐야함.
    context.read<DataProvider>().updateValueData(valueData);
  }

  List<int> unitGenerator(int unitId) {
    List<int> affectedUnits = [];

    if (unitId < 5) {
      affectedUnits = [0, 1, 2, 3, 4];
    } else if (unitId >= 5 && unitId < 10) {
      affectedUnits = [5, 6, 7, 8, 9];
    } else if (unitId >= 6 && unitId <= 15) {
      affectedUnits = [unitId];
    }

    return affectedUnits;
  }

  /// 카드 온오프 유닛별 제어
  onOnOffButtonPressed(
      int? selectedUnitId, BuildContext context, DataProvider dataProvider) {
    ValueData valueData = dataProvider.valueData!;
    List<int> affectedUnits = unitGenerator(selectedUnitId!);

    /// 온 오프 터치시 자동도 수동으로 변경
    /// 1번인 경우와 5번인 경우는 하위도 한번에 변경
    for (int unitId in affectedUnits) {
      valueData.deviceValue[unitId].unitStatus = 0;
    }
    for (var data in valueData.deviceValue) {
      data.unitMode = 0;
    }

    context.read<DataProvider>().updateValueData(valueData);
  }

  /// 개별 제어 모달
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
            child: Container(),
          ),
        );
      },
    );
  }
}

class _TopBar extends StatefulWidget {
  final OnToggle? onToggle;
  int selectedIndex;

  _TopBar({
    super.key,
    required this.onToggle,
    required this.selectedIndex,
  });

  @override
  State<_TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<_TopBar> {
  final dialogTextStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

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

            ///전체 전원 토글 스위치
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
              labels: const ['수동', '자동'],
              radiusStyle: true,
              onToggle: widget.onToggle,
            ),
          ],
        ),
      ),
    );
  }
}

typedef OnOffUnitButtonPressed = void Function(int? selectedUnitId);
typedef OnAutoUnitButtonToggled = void Function(int? index, int? seletedUnitId);

class _UnitCard extends StatelessWidget {
  final List<DeviceValue> units;
  final OnOffUnitButtonPressed onPressed;
  final OnAutoUnitButtonToggled onToggle;

  const _UnitCard({
    super.key,
    required this.units,
    required this.onPressed,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    List<DeviceValue> tempUnits = [];
    for (int i = 10; i < 15; i++) {
      tempUnits = [...tempUnits, units[i]];
    }
    final mergedUnits = [
      units[0],
      units[5],
      ...tempUnits,
    ];
    print(units[3].unitId);
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
                ...mergedUnits.map(
                  (e) => UnitCard(
                    condition: e.unitStatus == 1,
                    label: unitToLabel(e.unitId)!.label,
                    icon: unitToLabel(e.unitId)!.icon,
                    selectedTheme: e.unitStatus == 1 ? CARDS[0] : CARDS[1],
                    onPressed: () {
                      onPressed(e.unitId);
                    },
                    onToggle: (int? index) {
                      onToggle(index, e.unitId);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  UnitInfo? unitToLabel(int unitId) {
    UnitInfo unitInfo;

    if (unitId == 0) {
      unitInfo = UNITS[0];
      return unitInfo;
    } else if (unitId == 5) {
      unitInfo = UNITS[1];
      return unitInfo;
    } else if (unitId >= 10 && unitId < 15) {
      ///앤트리가 가진 Id - 10 한 값.
      unitInfo = UNITS[unitId - 8];
      return unitInfo;
    }
    return null;
  }
}

class _SettingButtons extends StatelessWidget {
  const _SettingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        /// 시간 제어 화면 전환 버튼
        FloatingActionButton.large(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const TimerSettingScreen();
                },
              ),
            );
          },
          heroTag: "timeButton",
          backgroundColor: colors[7],
          child: const Icon(
            Icons.timer,
            size: 50,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 16),

        /// 온도 제어 화면 전환 버튼
        FloatingActionButton.large(
          onPressed: () async {
            final data = await GetIt.I<AppDatabase>().getTemperatures();

            List<FlSpot> highData = data
                .map(
                  (e) => FlSpot(
                    e.id.toDouble() - 0.5,
                    e.highTemp,
                  ),
                )
                .toList();

            List<FlSpot> lowData = data
                .map(
                  (e) => FlSpot(
                    e.id.toDouble() - 0.5,
                    e.lowTemp,
                  ),
                )
                .toList();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return TemperatureSettingScreen(
                    highData: highData,
                    lowData: lowData,
                  );
                },
              ),
            );
          },
          heroTag: "tempButton",
          backgroundColor: colors[10],
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
