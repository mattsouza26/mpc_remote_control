import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/models/command.dart';
import '../../../../core/services/local_storage/models/storage_object.dart';
import '../../domain/entities/settings_entity.dart';

part 'settings_dto.g.dart';

@HiveType(typeId: 0)
class SettingsDTO extends SettingsEntity with StorageObject {
  const SettingsDTO({
    @HiveField(0) required super.isFirstOpening,
    @HiveField(1) required super.themeModeName,
    @HiveField(2) required super.keepScreenOn,
    @HiveField(3) required super.notification,
    @HiveField(4) required super.useHardwareVolumeKeys,
    @HiveField(5) required super.incomingCall,
    @HiveField(6) required super.afterCallEnd,
    @HiveField(7) required super.subnet,
    @HiveField(8) required super.ports,
    @HiveField(9) super.lastServer,
    @HiveField(10) required super.autoConnect,
    @HiveField(11) required super.unsupportedFiles,
    @HiveField(12) required super.fileExtension,
    @HiveField(13) required super.fullFileName,
    @HiveField(14) required super.jumpDistance,
    @HiveField(15) required super.customControls,
  });

  factory SettingsDTO.fromEntity(SettingsEntity entity) {
    return SettingsDTO(
      isFirstOpening: entity.isFirstOpening,
      themeModeName: entity.themeModeName,
      keepScreenOn: entity.keepScreenOn,
      notification: entity.notification,
      useHardwareVolumeKeys: entity.useHardwareVolumeKeys,
      incomingCall: entity.incomingCall,
      afterCallEnd: entity.afterCallEnd,
      subnet: entity.subnet,
      ports: entity.ports,
      lastServer: entity.lastServer,
      autoConnect: entity.autoConnect,
      unsupportedFiles: entity.unsupportedFiles,
      fileExtension: entity.fileExtension,
      fullFileName: entity.fullFileName,
      jumpDistance: entity.jumpDistance,
      customControls: entity.customControls,
    );
  }
}
