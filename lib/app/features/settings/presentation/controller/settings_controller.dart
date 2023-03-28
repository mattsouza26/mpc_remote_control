import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/enums/jump_distance.dart';
import '../../../../core/models/command.dart';
import '../../../../core/models/server.dart';
import '../../data/dto/settings_dto.dart';
import '../../domain/usecases/delete_settings_usecase.dart';
import '../../domain/usecases/get_subnet_usecase.dart';
import '../../domain/usecases/load_settings_usecase.dart';
import '../../domain/usecases/save_settings_usecase.dart';

// ignore_for_file: prefer_final_fields (WORKS)
class SettingsController extends ChangeNotifier {
  final SaveSettingsUseCase _saveSettingsUseCase;
  final DeleteSettingsUseCase _deleteSettingsUseCase;
  final LoadSettingsUseCase _loadSettingsUseCase;
  final GetSubnetUseCase _getSubnetUseCase;

  SettingsController(
    this._loadSettingsUseCase,
    this._saveSettingsUseCase,
    this._deleteSettingsUseCase,
    this._getSubnetUseCase,
  );

  final ValueNotifier<bool> isFirstOpening = ValueNotifier(true);
  final ValueNotifier<ThemeMode> appTheme = ValueNotifier(ThemeMode.system);
  final ValueNotifier<bool> keepScreenOn = ValueNotifier(false);
  final ValueNotifier<bool> notification = ValueNotifier(false);
  final ValueNotifier<bool> useHardwareVolumeKeys = ValueNotifier(true);
  final ValueNotifier<bool> incomingCall = ValueNotifier(false);
  final ValueNotifier<bool> afterCallEnd = ValueNotifier(false);
  final ValueNotifier<String> subnet = ValueNotifier("192.168.0");
  final ValueNotifier<List<int>> ports = ValueNotifier([13579]);
  final ValueNotifier<Server?> lastServer = ValueNotifier(null);
  final ValueNotifier<bool> autoConnect = ValueNotifier(true);
  final ValueNotifier<bool> unsupportedFiles = ValueNotifier(false);
  final ValueNotifier<bool> fileExtension = ValueNotifier(false);
  final ValueNotifier<bool> fullFileName = ValueNotifier(true);
  final ValueNotifier<JumpDistance> jumpDistance = ValueNotifier(JumpDistance.small);
  final ValueNotifier<List<Command>> customControls = ValueNotifier([]);

  late final Listenable _settingsListener;

  Future<void> init() async {
    await _loadSettings();
    _settingsListener = Listenable.merge([
      isFirstOpening,
      appTheme,
      keepScreenOn,
      notification,
      useHardwareVolumeKeys,
      incomingCall,
      afterCallEnd,
      subnet,
      lastServer,
      autoConnect,
      unsupportedFiles,
      fileExtension,
      fullFileName,
      jumpDistance,
      customControls,
    ]);
    _settingsListener.addListener(() async {
      await _save();
      notifyListeners();
    });
  }

  Future<void> _loadSettings() async {
    final result = await _loadSettingsUseCase();
    final settings = result.getOrNull();

    if (settings != null) {
      isFirstOpening.value = settings.isFirstOpening;
      appTheme.value = ThemeMode.values.firstWhere((theme) => theme.name == settings.themeModeName);
      keepScreenOn.value = settings.keepScreenOn;
      notification.value = settings.notification;
      useHardwareVolumeKeys.value = settings.useHardwareVolumeKeys;
      incomingCall.value = settings.incomingCall;
      afterCallEnd.value = settings.afterCallEnd;
      subnet.value = settings.subnet;
      ports.value = settings.ports;
      lastServer.value = settings.lastServer;
      autoConnect.value = settings.autoConnect;
      unsupportedFiles.value = settings.unsupportedFiles;
      fileExtension.value = settings.fileExtension;
      fullFileName.value = settings.fullFileName;
      jumpDistance.value = JumpDistance.values.firstWhere((jump) => jump.name == settings.jumpDistance);
      customControls.value = settings.customControls;
    } else {
      await _getTheme();
      await _getSubnet();
    }
  }

  Future<void> _getTheme() async {
    final Brightness brightness = MediaQueryData.fromWindow(WidgetsBinding.instance.window).platformBrightness;
    appTheme.value = brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> _getSubnet() async {
    final result = await _getSubnetUseCase();
    if (result.isError()) return;
    final newSubnet = result.getOrNull();
    if (newSubnet == null) return;
    subnet.value = newSubnet;
  }

  void toggleTheme() {
    appTheme.value = appTheme.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }

  void clearAppCache() async {
    await _deleteSettingsUseCase();
    SystemNavigator.pop();
  }

  Future<void> _save() async {
    await _saveSettingsUseCase(
      SettingsDTO(
        isFirstOpening: isFirstOpening.value,
        themeModeName: appTheme.value.name,
        keepScreenOn: keepScreenOn.value,
        notification: notification.value,
        useHardwareVolumeKeys: useHardwareVolumeKeys.value,
        incomingCall: incomingCall.value,
        afterCallEnd: afterCallEnd.value,
        subnet: subnet.value,
        ports: ports.value,
        lastServer: lastServer.value,
        autoConnect: autoConnect.value,
        unsupportedFiles: unsupportedFiles.value,
        fileExtension: fileExtension.value,
        fullFileName: fullFileName.value,
        jumpDistance: jumpDistance.value.name,
        customControls: customControls.value,
      ),
    );
  }
}
