import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/model/device_value_data_model.dart';
import 'package:smart_farm/provider/data_provider.dart';
import 'package:smart_farm/provider/unit_serve_data.dart';
import 'package:smart_farm/service/socket_service.dart';

class EachUnitControlModalPopup extends StatefulWidget {
  final List<int> setChannel;

  const EachUnitControlModalPopup({
    super.key,
    required this.setChannel,
  });

  @override
  State<EachUnitControlModalPopup> createState() =>
      _EachUnitControlModalPopupState();
}

class _EachUnitControlModalPopupState extends State<EachUnitControlModalPopup> {
  List<UnitInfo> mergedUnits = [];

  @override
  void initState() {
    super.initState();
    mergedUnits = GetIt.I<DataProvider>().units!;
  }

  @override
  Widget build(BuildContext context) {
    List<String> labelList = [];
    for (UnitInfo unit in mergedUnits) {
      if (unit.setChannel == widget.setChannel) {
        for (int i = 0; i < widget.setChannel.length; i++) {
          labelList.add(unit.unitName);
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.all(150.0),
      child: Material(
        color: colors[2],
        borderRadius: BorderRadius.circular(10.0),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5, // 각 항목의 너비를 고정
              mainAxisSpacing: 8.0, // 세로 간격
              crossAxisSpacing: 8.0, // 가로 간격
            ),
            itemCount: widget.setChannel.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onEachUnitTap(index, labelList[index]);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),

                    /// 타이머의 번호가 현재 할당된 번호와 같으면
                    border: isOn(index, labelList[index])
                        ? Border.all(width: 2, color: Colors.white)
                        : null,
                    color:
                        isOn(index, labelList[index]) ? colors[3] : colors[1],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          labelList[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          index.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  bool isOn(int index, String label) {
    final isOn = GetIt.I<DataProvider>()
        .deviceValueData!
        .deviceValue[widget.setChannel[index]]
        .unitStatus;
    if (label == '차광막') {
      return isOn == 2 ? true : false;
    } else {
      return isOn == 1 ? true : false;
    }
  }

  void onEachUnitTap(int index, String label) {
    DeviceValue deviceData = GetIt.I<DataProvider>()
        .deviceValueData!
        .deviceValue[widget.setChannel[index]];

    if (label == '차광막') {
      deviceData.unitStatus = deviceData.unitStatus == 1 ? 2 : 1;
    } else {
      deviceData.unitStatus = deviceData.unitStatus == 0 ? 1 : 0;
    }

    final newDeviceData = GetIt.I<DataProvider>().deviceValueData!;

    GetIt.I<DataProvider>().updateDeviceValueData(newDeviceData);
    GetIt.I<SocketService>().sendDeviceValueData(newDeviceData);
    setState(() {});
  }
}
