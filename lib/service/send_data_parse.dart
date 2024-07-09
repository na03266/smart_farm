import 'dart:typed_data';

import 'package:smart_farm/model/device_value_data_model.dart';
import 'package:smart_farm/model/set_up_data_model.dart';
import 'package:smart_farm/service/crc_16.dart';

/// 셋업 데이터 요청 함수
Uint8List cmdDataToBytes() {
  final buffer = ByteData(4); // 전체 데이터 크기
  buffer.setUint8(0, 255);
  buffer.setUint8(1, 1);
  CRC16.calculateCRC16m(buffer.buffer.asUint8List(), 4);
  print(buffer.buffer.asUint8List());

  return buffer.buffer.asUint8List();
}

///셋업데이터 바이트 전환
Uint8List setupDataToBytes(SetupData setupData) {
  final buffer = ByteData(5504); // 전체 데이터 크기
  int offset = 0;

  // controllerId
  buffer.buffer
      .asUint8List()
      .setRange(offset, offset + 6, setupData.controllerId);
  offset += 6;

  // setTempL
  for (int temp in setupData.setTempL) {
    buffer.setInt16(offset, temp, Endian.big);
    offset += 2;
  }
  // setTempH
  for (int temp2 in setupData.setTempH) {
    buffer.setInt16(offset, temp2, Endian.big);
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
    buffer.setUint16(offset, device.unitMoveTime, Endian.big);
    offset += 2;
    buffer.setUint16(offset, device.unitStopTime, Endian.big);
    offset += 2;
    buffer.setUint16(offset, device.unitOpenTime, Endian.big);
    offset += 2;
    buffer.setUint16(offset, device.unitCloseTime, Endian.big);
    offset += 2;
    buffer.setUint8(offset++, device.unitOPTime);
    buffer.setUint8(offset++, device.unitTimerSet);
  }

  // setSensor
  for (SetupSensor sensor in setupData.setSensor) {
    buffer.setUint8(offset++, sensor.sensorID);
    buffer.setUint8(offset++, sensor.sensorCH);
    buffer.setUint8(offset++, sensor.sensorReserved);
    buffer.setFloat32(offset, sensor.sensorMULT, Endian.big);
    offset += 4;
    buffer.setFloat32(offset, sensor.sensorOffSet, Endian.big);
    offset += 4;
    buffer.buffer.asUint8List().setRange(offset, offset + 256, sensor.sensorEQ);
    offset += 256;
  }

  buffer.setUint8(offset++, setupData.dummy1);
  buffer.setUint8(offset++, setupData.dummy2);

  CRC16.calculateCRC16m(buffer.buffer.asUint8List(), 5504);

  return buffer.buffer.asUint8List();
}

/// 장지 값 바이트 전환
Uint8List deviceValueDataToBytes(DeviceValueData valueData) {
  int offset = 0;
  final buffer = ByteData(56); // 전체 데이터 크기

  // controllerId 6
  buffer.buffer
      .asUint8List()
      .setRange(offset, offset + 6, valueData.controllerId);
  offset += 6;

  // deviceValue 16*3 = 48
  for (DeviceValue device in valueData.deviceValue) {
    buffer.setUint8(offset++, device.unitId);
    buffer.setUint8(offset++, device.unitMode);
    buffer.setUint8(offset++, device.unitStatus);
  }

  // CRC 계산 2
  CRC16.calculateCRC16m(buffer.buffer.asUint8List(), 56);

  return buffer.buffer.asUint8List();
}
