// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:mpc_remote_control/app/core/models/server.dart';

import '../../../../core/models/command.dart';
import 'app_settings_entity.dart';
import 'control_settings_entity.dart';
import 'file_settings_entity.dart';
import 'server_settings_entity.dart';

abstract class SettingsEntity implements AppSettingsEntity, ServerSettingsEntity, FileSettingsEntity, ControlSettingsEntity {
  @override
  final bool isFirstOpening;
  @override
  final String themeModeName;
  @override
  final bool keepScreenOn;
  @override
  final bool notification;
  @override
  final bool useHardwareVolumeKeys;
  @override
  final bool incomingCall;
  @override
  final bool afterCallEnd;
  @override
  final String subnet;
  @override
  final List<int> ports;
  @override
  final Server? lastServer;
  @override
  final bool autoConnect;
  @override
  final bool unsupportedFiles;
  @override
  final bool fileExtension;
  @override
  final bool fullFileName;
  @override
  final String jumpDistance;
  @override
  final List<Command> customControls;

  const SettingsEntity({
    required this.isFirstOpening,
    required this.themeModeName,
    required this.keepScreenOn,
    required this.notification,
    required this.useHardwareVolumeKeys,
    required this.incomingCall,
    required this.afterCallEnd,
    required this.subnet,
    required this.ports,
    this.lastServer,
    required this.autoConnect,
    required this.unsupportedFiles,
    required this.fileExtension,
    required this.fullFileName,
    required this.jumpDistance,
    required this.customControls,
  });
}
