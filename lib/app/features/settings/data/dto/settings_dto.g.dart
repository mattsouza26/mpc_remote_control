// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsDTOAdapter extends TypeAdapter<SettingsDTO> {
  @override
  final int typeId = 0;

  @override
  SettingsDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return SettingsDTO(
      isFirstOpening: fields[0] as bool,
      themeModeName: fields[1] as String,
      keepScreenOn: fields[2] as bool,
      notification: fields[3] as bool,
      useHardwareVolumeKeys: fields[4] as bool,
      incomingCall: fields[5] as bool,
      afterCallEnd: fields[6] as bool,
      subnet: fields[7] as String,
      ports: fields[8] as List<int>,
      lastServer: fields[9],
      autoConnect: fields[10] as bool,
      unsupportedFiles: fields[11] as bool,
      fileExtension: fields[12] as bool,
      fullFileName: fields[13] as bool,
      jumpDistance: fields[14] as String,
      customControls: List.from(fields[15]).cast<Command>(),
    );
  }

  @override
  void write(BinaryWriter writer, SettingsDTO obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.isFirstOpening)
      ..writeByte(1)
      ..write(obj.themeModeName)
      ..writeByte(2)
      ..write(obj.keepScreenOn)
      ..writeByte(3)
      ..write(obj.notification)
      ..writeByte(4)
      ..write(obj.useHardwareVolumeKeys)
      ..writeByte(5)
      ..write(obj.incomingCall)
      ..writeByte(6)
      ..write(obj.afterCallEnd)
      ..writeByte(7)
      ..write(obj.subnet)
      ..writeByte(8)
      ..write(obj.ports)
      ..writeByte(9)
      ..write(obj.lastServer)
      ..writeByte(10)
      ..write(obj.autoConnect)
      ..writeByte(11)
      ..write(obj.unsupportedFiles)
      ..writeByte(12)
      ..write(obj.fileExtension)
      ..writeByte(13)
      ..write(obj.fullFileName)
      ..writeByte(14)
      ..write(obj.jumpDistance)
      ..writeByte(15)
      ..write(obj.customControls);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SettingsDTOAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
