import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/model/device_value_data_model.dart';
import 'package:smart_farm/provider/data_provider.dart';
import 'package:smart_farm/provider/unit_info.dart';
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
  void initState() {
    super.initState();
    GetIt.I<SocketService>().requestData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        if (dataProvider.deviceValueData == null) {
          return const Center(child: CircularProgressIndicator());
        }
        List<DeviceValue> units = dataProvider.deviceValueData!.deviceValue;
        List<int> tempL = dataProvider.setupData!.setTempL;
        List<int> tempH = dataProvider.setupData!.setTempH;

        return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Scaffold(
              body: Column(
                children: [
                  _TopBar(
                    onToggle: (int? index) {
                      onAllUnitToAutoToggle(index, context, dataProvider);
                    },

                    /// 장치중 하나라도 수동이면 전체버튼 수동 표시
                    selectedIndex: units.any((u) => u.unitMode == 0) ? 0 : 1,
                  ),
                  Expanded(
                    child: _UnitCard(
                      units: units,
                      onPressed: (List<int> selectedUnits) {
                        onOnOffButtonPressed(
                            selectedUnits, context, dataProvider);
                      },
                      onToggle: (int? index, List<int> selectedUnits) {
                        onAutoToggle(
                            index, selectedUnits, context, dataProvider);
                      },
                    ),
                  ),
                ],
              ),
              floatingActionButton: _SettingButtons(
                dataProvider: dataProvider,
                tempL: tempL,
                tempH: tempH,
              ),
            ));
      },
    );
  }

  ///버튼 전체 통합 제어
  Future<void> onAllUnitToAutoToggle(
      int? index, BuildContext context, DataProvider dataProvider) async {
    DeviceValueData valueData = dataProvider.deviceValueData!;

    /// 전체 유닛 루프 돌면서
    for (DeviceValue value in valueData.deviceValue) {
      value.unitMode = index!;
    }
    context.read<DataProvider>().updateDeviceValueData(valueData);

    /// 장치 값 전송
    GetIt.I<SocketService>().sendDeviceValueData(dataProvider.deviceValueData!);
  }

  onAutoToggle(int? index, List<int> selectedUnits, BuildContext context,
      DataProvider dataProvider) {
    DeviceValueData valueData = dataProvider.deviceValueData!;

    for (int i in selectedUnits) {
      valueData.deviceValue[i].unitMode = index!;
    }

    context.read<DataProvider>().updateDeviceValueData(valueData);

    GetIt.I<SocketService>().sendDeviceValueData(dataProvider.deviceValueData!);
  }

  /// 카드 온오프 유닛별 제어
  onOnOffButtonPressed(List<int> selectedUnits, BuildContext context,
      DataProvider dataProvider) {
    DeviceValueData valueData = dataProvider.deviceValueData!;

    /// 1번인 경우와 5번인 경우는 하위도 한번에 변경
    for (int unitId in selectedUnits) {
      int index = valueData.deviceValue[unitId].unitId;

      ///해당 장치의 타입
      int temp = dataProvider.setupData!.setDevice[index].unitType;

      if (temp == 1) {
        valueData.deviceValue[unitId].unitStatus =
            valueData.deviceValue[unitId].unitStatus == 1 ? 2 : 1;
        valueData.deviceValue[unitId].unitMode = 0;
        print(valueData.deviceValue[unitId].unitStatus);
      } else {
        valueData.deviceValue[unitId].unitStatus =
            valueData.deviceValue[unitId].unitStatus == 1 ? 0 : 1;
        valueData.deviceValue[unitId].unitMode = 0;
      }
    }
    DeviceValueData newDeviceValueData =
        GetIt.I<DataProvider>().deviceValueData!;
    dataProvider.updateDeviceValueData(newDeviceValueData);

    GetIt.I<SocketService>().sendDeviceValueData(newDeviceValueData);
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

typedef OnOffUnitButtonPressed = void Function(List<int> selectedUnitId);
typedef OnAutoUnitButtonToggled = void Function(
    int? index, List<int> seletedUnitId);

class _UnitCard extends StatefulWidget {
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
  State<_UnitCard> createState() => _UnitCardState();
}

class _UnitCardState extends State<_UnitCard> {
  List<UnitInfo> mergedUnits = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors[2],
      child: Consumer<DataProvider>(builder: (context, dataProvider, child) {
        mergedUnits = dataProvider.units!;

        for (UnitInfo unit in mergedUnits) {
          List<DeviceValue> tempUnits = [];

          /// status, isAuto를 모두 들고 있음.
          for (int i in unit.setChannel) {
            tempUnits.add(widget.units[i]);
          }

          /// 채널 목록 안의 개채의 아이디 중 하나라도 1이면
          if (unit.unitName == '차광막') {
            unit.status = tempUnits.any((e) => e.unitStatus == 2);
          } else {
            unit.status = tempUnits.any((e) => e.unitStatus == 1);
          }
          unit.isAuto = !tempUnits.any((e) => e.unitMode == 1);
        }

        return CustomScrollView(
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
                      condition: e.status,
                      label: e.unitName,
                      icon: e.icon,
                      selectedTheme: e.status ? CARDS[0] : CARDS[1],
                      isAuto: e.isAuto ? 0 : 1,
                      onPressed: () {
                        widget.onPressed(e.setChannel);
                      },
                      onToggle: (int? index) {
                        widget.onToggle(index, e.setChannel);
                      },
                      setChannel: e.setChannel,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _SettingButtons extends StatelessWidget {
  final DataProvider dataProvider;
  final List<int> tempL;
  final List<int> tempH;

  const _SettingButtons({
    super.key,
    required this.tempL,
    required this.tempH,
    required this.dataProvider,
  });

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
            List<FlSpot> highData = tempH
                .asMap()
                .entries
                .map(
                  (e) => FlSpot(
                    e.key.toDouble() + 0.5,
                    e.value.toDouble(),
                  ),
                )
                .toList();

            List<FlSpot> lowData = tempL
                .asMap()
                .entries
                .map(
                  (e) => FlSpot(
                    e.key.toDouble() + 0.5,
                    e.value.toDouble(),
                  ),
                )
                .toList();
            final resp = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return TemperatureSettingScreen(
                    highData: highData,
                    lowData: lowData,
                  );
                },
              ),
            );
            dataProvider.setupData!.setTempL = resp[0];
            dataProvider.setupData!.setTempH = resp[1];

            context
                .read<DataProvider>()
                .updateSetupData(dataProvider.setupData!);

            GetIt.I<SocketService>().sendSetupData(dataProvider.setupData!);
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
