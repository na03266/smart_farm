import 'dart:typed_data';

import 'package:smart_farm/model/device_value_data_model.dart';
import 'package:smart_farm/model/sensor_value_data_model.dart';
import 'package:smart_farm/model/set_up_data_model.dart';
import 'package:smart_farm/service/crc_16.dart';

dynamic parseData(Uint8List data) {
  if (data.length == 56) {
    return parseDeviceValueData(data);
  } else if (data.length == 76) {
    return parseSensorValueData(data);
  } else if (data.length == 5504) {
    return parseSetupData(data);
  } else {
    print('데이터 길이가 틀렸습니다.${data.length}');
    return null;
  }
}

DeviceValueData? parseDeviceValueData(Uint8List data) {
  if (!CRC16.calculateCRC16s(data, data.length)) {
    print('CRC16 검증 실패 dev');
    return null;
  }

  final ByteData byteData = ByteData.sublistView(data);
  int offset = 0;

  Uint8List controllerId = data.sublist(offset, offset + 6);
  offset += 6;

  List<DeviceValue> deviceValues = List.generate(16, (index) {
    return DeviceValue(
      unitId: data[offset++],
      unitMode: data[offset++],
      unitStatus: data[offset++],
    );
  });

  int crcL = data[offset++];
  int crcH = data[offset];

  return DeviceValueData(
    controllerId: controllerId,
    deviceValue: deviceValues,
    crcL: crcL,
    crcH: crcH,
  );
}

SensorValueData? parseSensorValueData(Uint8List data) {
  if (!CRC16.calculateCRC16s(data, data.length)) {
    print('CRC 검증 실패 value');
    return null;
  }

  final ByteData byteData = ByteData.sublistView(data);
  int offset = 0;

  Uint8List controllerId = data.sublist(offset, offset + 6);
  offset += 6;

  offset += 2; // dummy bytes

  List<SensorValue> sensorValues = List.generate(8, (index) {
    int sensorId = data[offset++];
    offset += 3; // 3 bytes reserved
    double sensorValue = byteData.getFloat32(offset, Endian.big);
    offset += 4;
    return SensorValue(
      sensorId: sensorId,
      sensorValue: sensorValue,
    );
  });

  int dummy1 = data[offset++];
  int dummy2 = data[offset++];
  int crcL = data[offset++];
  int crcH = data[offset];

  return SensorValueData(
    controllerId: controllerId,
    sensorValue: sensorValues,
    dummy1: dummy1,
    dummy2: dummy2,
    crcL: crcL,
    crcH: crcH,
  );
}

SetupData? parseSetupData(Uint8List data) {
  print(CRC16.calculateCRC16s(data, data.length));
  if (!CRC16.calculateCRC16s(data, data.length)) {
    print('CRC 검증 실패 setup');
    return null; // CRC16 검증 실패 시 null 반환
  }
  final ByteData byteData = ByteData.sublistView(data);
  int offset = 0;

  Uint8List controllerId = data.sublist(offset, offset + 6);
  offset += 6;

  List<int> setTempL = List.generate(48, (index) {
    int temp = byteData.getInt16(offset, Endian.big);
    offset += 2;
    return temp;
  });
  List<int> setTempH = List.generate(48, (index) {
    int temp = byteData.getInt16(offset, Endian.big);
    offset += 2;
    return temp;
  });

  int tempGap = data[offset++];
  int heatTemp = data[offset++];
  int iceType = data[offset++];
  int alarmType = data[offset++];
  int alarmTempH = data[offset++];
  int alarmTempL = data[offset++];
  Uint8List tel = data.sublist(offset, offset + 13);
  offset += 13;
  int awsBit = data[offset++];

  List<Uint8List> unitTimer = List.generate(16, (index) {
    Uint8List timer = data.sublist(offset, offset + 180);
    offset += 180;
    return timer;
  });

  List<SetupDevice> setDevice = List.generate(16, (index) {
    SetupDevice temp = SetupDevice(
      unitId: data[offset++],
      unitType: data[offset++],
      unitCH: data[offset++],
      unitOpenCH: data[offset++],
      unitCloseCH: data[offset++],
      unitMoveTime: byteData.getUint16(offset+1, Endian.big),
      unitStopTime: byteData.getUint16(offset + 3, Endian.big),
      unitOpenTime: byteData.getUint16(offset + 5, Endian.big),
      unitCloseTime: byteData.getUint16(offset + 7, Endian.big),
      unitOPTime: data[offset + 9],
      unitTimerSet: data[offset + 10],
    );
    offset += 11;
    return temp;
  });

  offset+=2;

  List<SetupSensor> setSensor = List.generate(8, (index) {

    SetupSensor temp = SetupSensor(
      sensorID: data[offset++],
      sensorCH: data[offset++],
      sensorReserved: data[offset++],
      sensorMULT: byteData.getFloat32(offset+1, Endian.big),
      sensorOffSet: byteData.getFloat32(offset + 5, Endian.big),
      sensorEQ: data.sublist(offset + 9, offset + 265),
    );
    offset += 265;
    return temp;
  });

  int dummy1 = data[offset++];
  int dummy2 = data[offset++];
  int crcL = data[offset++];
  int crcH = data[offset++];

  return SetupData(
    controllerId: controllerId,
    setTempL: setTempL,
    setTempH: setTempH,
    tempGap: tempGap,
    heatTemp: heatTemp,
    iceType: iceType,
    alarmType: alarmType,
    alarmTempH: alarmTempH,
    alarmTempL: alarmTempL,
    tel: tel,
    awsBit: awsBit,
    unitTimer: unitTimer,
    setDevice: setDevice,
    setSensor: setSensor,
    dummy1: dummy1,
    dummy2: dummy2,
    crcL: crcL,
    crcH: crcH,
  );
}
