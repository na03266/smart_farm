import 'dart:typed_data';

import 'package:smart_farm/model/set_up_data_model.dart';
import 'package:smart_farm/model/value_model.dart';
import 'package:smart_farm/service/crc_16.dart';

dynamic parseData(Uint8List data) {
  if (data.length == 124) {
    return parseValueData(data);
  } else {
    return parseSetupData(data);
  }
}

ValueData? parseValueData(Uint8List data) {
  if (data.length != 124) {
    print('데이터 길이가 124바이트가 아닙니다.');
    return null;
  }

  if (!CRC16.calculateCRC16s(data, data.length)) {
    print('CRC16 검증 실패');
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

  offset += 2; // dummy bytes

  List<SensorValue> sensorValues = List.generate(8, (index) {
    int sensorId = data[offset++];
    offset += 3; // 3 bytes reserved
    double sensorValue = byteData.getFloat32(offset, Endian.little);
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

  return ValueData(
    controllerId: controllerId,
    deviceValue: deviceValues,
    sensorValue: sensorValues,
    dummy1: dummy1,
    dummy2: dummy2,
    crcL: crcL,
    crcH: crcH,
  );
}

SetupData? parseSetupData(Uint8List data) {
  if (!CRC16.calculateCRC16s(data, data.length)) {
    print('CRC16 검증 실패');
    return null; // CRC16 검증 실패 시 null 반환
  }

  final ByteData byteData = ByteData.sublistView(data);
  int offset = 0;

  Uint8List controllerId = data.sublist(offset, offset + 6);
  offset += 6;

  List<int> setTemp = List.generate(48, (index) {
    int temp = byteData.getInt16(offset, Endian.little);
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
    return SetupDevice(
      unitId: data[offset++],
      unitType: data[offset++],
      unitCH: data[offset++],
      unitOpenCH: data[offset++],
      unitCloseCH: data[offset++],
      unitMoveTime: byteData.getUint16(offset, Endian.little),
      unitStopTime: byteData.getUint16(offset + 2, Endian.little),
      unitOpenTime: byteData.getUint16(offset + 4, Endian.little),
      unitCloseTime: byteData.getUint16(offset + 6, Endian.little),
      unitOPTime: data[offset + 8],
      unitTimerSet: data[offset + 9],
    );
    offset += 10;
  });

  List<SetupSensor> setSensor = List.generate(8, (index) {
    SetupSensor sensor = SetupSensor(
      sensorID: data[offset++],
      sensorCH: data[offset++],
      sensorReserved: data[offset++],
      sensorMULT: byteData.getFloat32(offset, Endian.little),
      sensorOffSet: byteData.getFloat32(offset + 4, Endian.little),
      sensorEQ: data.sublist(offset + 8, offset + 264),
    );
    offset += 264;
    return sensor;
  });

  int dummy1 = data[offset++];
  int dummy2 = data[offset++];
  int crcL = data[offset++];
  int crcH = data[offset++];

  return SetupData(
    controllerId: controllerId,
    setTemp: setTemp,
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

/// 셋업 데이터 요청 함수
Uint8List cmdDataToBytes(int i) {
  final buffer = ByteData(4); // 전체 데이터 크기
  buffer.setUint8(0, 255);
  buffer.setUint8(1, i);
  CRC16.calculateCRC16m(buffer.buffer.asUint8List(), 4);
  print(buffer.buffer.asUint8List());

  return buffer.buffer.asUint8List();
}

Uint8List setupDataToBytes(SetupData setupData) {
  final buffer = ByteData(5408); // 전체 데이터 크기
  int offset = 0;

  // controllerId
  buffer.buffer
      .asUint8List()
      .setRange(offset, offset + 6, setupData.controllerId);
  offset += 6;

  // setTemp
  for (int temp in setupData.setTemp) {
    buffer.setInt16(offset, temp, Endian.little);
    offset += 2;
  }

  buffer.setUint8(offset++, setupData.tempGap);
  buffer.setUint8(offset++, setupData.heatTemp);
  buffer.setUint8(offset++, setupData.iceType);
  buffer.setUint8(offset++, setupData.alarmType);
  buffer.setUint8(offset++, setupData.alarmTempH);
  buffer.setUint8(offset++, setupData.alarmTempL);

  buffer.buffer.asUint8List().setRange(offset, offset + 13, setupData.tel);
  offset += 13;

  buffer.setUint8(offset++, setupData.awsBit);

  // unitTimer
  for (Uint8List timer in setupData.unitTimer) {
    buffer.buffer.asUint8List().setRange(offset, offset + 180, timer);
    offset += 180;
  }

  // setDevice
  for (SetupDevice device in setupData.setDevice) {
    buffer.setUint8(offset++, device.unitId);
    buffer.setUint8(offset++, device.unitType);
    buffer.setUint8(offset++, device.unitCH);
    buffer.setUint8(offset++, device.unitOpenCH);
    buffer.setUint8(offset++, device.unitCloseCH);
    buffer.setUint16(offset, device.unitMoveTime, Endian.little);
    offset += 2;
    buffer.setUint16(offset, device.unitStopTime, Endian.little);
    offset += 2;
    buffer.setUint16(offset, device.unitOpenTime, Endian.little);
    offset += 2;
    buffer.setUint16(offset, device.unitCloseTime, Endian.little);
    offset += 2;
    buffer.setUint8(offset++, device.unitOPTime);
    buffer.setUint8(offset++, device.unitTimerSet);
  }

  // setSensor
  for (SetupSensor sensor in setupData.setSensor) {
    buffer.setUint8(offset++, sensor.sensorID);
    buffer.setUint8(offset++, sensor.sensorCH);
    buffer.setUint8(offset++, sensor.sensorReserved);
    buffer.setFloat32(offset, sensor.sensorMULT, Endian.little);
    offset += 4;
    buffer.setFloat32(offset, sensor.sensorOffSet, Endian.little);
    offset += 4;
    buffer.buffer.asUint8List().setRange(offset, offset + 256, sensor.sensorEQ);
    offset += 256;
  }

  buffer.setUint8(offset++, setupData.dummy1);
  buffer.setUint8(offset++, setupData.dummy2);

  // CRC 계산
  Uint8List dataForCRC = buffer.buffer.asUint8List(0, 5406);
  int crc = CRC16.calculateCRC16(dataForCRC, 5406);
  buffer.setUint8(5406, crc & 0xFF);
  buffer.setUint8(5407, (crc >> 8) & 0xFF);

  return buffer.buffer.asUint8List();
}

Uint8List valueDataToBytes(ValueData valueData) {
  final buffer = ByteData(124); // 전체 데이터 크기
  int offset = 0;

  // controllerId
  buffer.buffer.asUint8List().setRange(offset, offset + 6, valueData.controllerId);
  offset += 6;

  // deviceValue
  for (DeviceValue device in valueData.deviceValue) {
    buffer.setUint8(offset++, device.unitId);
    buffer.setUint8(offset++, device.unitMode);
    buffer.setUint8(offset++, device.unitStatus);
  }

  // dummy bytes
  buffer.setUint8(offset++, 0);
  buffer.setUint8(offset++, 0);

  // sensorValue
  for (SensorValue sensor in valueData.sensorValue) {
    buffer.setUint8(offset++, sensor.sensorId);
    buffer.setUint8(offset++, 0); // reserved
    buffer.setUint8(offset++, 0); // reserved
    buffer.setUint8(offset++, 0); // reserved
    buffer.setFloat32(offset, sensor.sensorValue, Endian.little);
    offset += 4;
  }

  // dummy1, dummy2
  buffer.setUint8(offset++, valueData.dummy1);
  buffer.setUint8(offset++, valueData.dummy2);

  // CRC 계산
  Uint8List dataForCRC = buffer.buffer.asUint8List(0, 122);
  int crc = CRC16.calculateCRC16(dataForCRC, 122);
  buffer.setUint8(122, crc & 0xFF);
  buffer.setUint8(123, (crc >> 8) & 0xFF);

  return buffer.buffer.asUint8List();
}