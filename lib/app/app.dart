import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mpc_remote_control/app/core/services/device_handler/device_handler_service.dart';

import '../main.dart';
import 'core/routes/app_route.dart';
import 'core/services/device_handler/enums/call_event.dart';
import 'core/services/local_notifications/models/notification_response.dart';
import 'core/themes/app_theme.dart';
import 'core/utils/commands_utils.dart';
import 'features/server/presentation/controller/server_controller.dart';
import 'features/settings/presentation/controller/settings_controller.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final SettingsController _settingsController;
  late final ServerController _serverController;
  late final DeviceHandlerService _deviceHandler;
  late ThemeMode _appTheme;

  @override
  void initState() {
    _deviceHandler = GetIt.I.get<DeviceHandlerService>();
    _settingsController = GetIt.I.get<SettingsController>();
    _serverController = GetIt.I.get<ServerController>();

    _settingsController.appTheme.addListener(_updateTheme);
    _serverController.addListener(_saveSelectedServer);
    _settingsController.addListener(_handleSettings);
    onNotificationReceive.listen(_handleNotification);

    _onAppInit();
    super.initState();
  }

  @override
  void dispose() async {
    _serverController.dispose();
    _settingsController.dispose();
    GetIt.I.reset();
    super.dispose();
  }

  void _onAppInit() async {
    _appTheme = _settingsController.appTheme.value;
    if (_settingsController.autoConnect.value && _settingsController.lastServer.value != null) {
      _serverController.selectServer(_settingsController.lastServer.value!);
    }
    if (_settingsController.notification.value && !_serverController.isShowingNotification()) {
      _serverController.showNotification();
    }

    if (_settingsController.keepScreenOn.value) {
      _deviceHandler.enableScreenOn();
    }

    if (_settingsController.useHardwareVolumeKeys.value) {
      _deviceHandler.volumeListener(_handleDeviceVolumesKey);
    }
    if (_settingsController.incomingCall.value || _settingsController.afterCallEnd.value) {
      _deviceHandler.callsListener(_handlerCalls);
    }
  }

  void _updateTheme() {
    setState(() {
      _appTheme = _settingsController.appTheme.value;
    });
  }

  void _saveSelectedServer() {
    _settingsController.lastServer.value = _serverController.selected.server;
  }

  void _handleSettings() async {
    if (_settingsController.notification.value) {
      _serverController.showNotification();
    } else {
      _serverController.cancelNotification();
    }

    if (_settingsController.keepScreenOn.value) {
      _deviceHandler.enableScreenOn();
    } else {
      _deviceHandler.disableScreenOn();
    }

    if (_settingsController.useHardwareVolumeKeys.value) {
      _deviceHandler.volumeListener(_handleDeviceVolumesKey);
    } else {
      _deviceHandler.removeVolumeListener(_handleDeviceVolumesKey);
    }
    if (_settingsController.incomingCall.value || _settingsController.afterCallEnd.value) {
      _deviceHandler.callsListener(_handlerCalls);
    } else {
      _deviceHandler.removeCallsListener(_handlerCalls);
    }
  }

  void _handleNotification(LocalNotificationResponse? response) {
    switch (response?.actionId) {
      case 'fast_rewind':
        _serverController.sendCommand(ControllerCommands.jumpBackward(_settingsController.jumpDistance.value));
        break;
      case 'skip_previous':
        _serverController.sendCommand(ControllerCommands.previousFile);
        break;
      case 'play':
        _serverController.sendCommand(ControllerCommands.play);
        break;
      case 'pause':
        _serverController.sendCommand(ControllerCommands.pause);
        break;
      case 'skip_next':
        _serverController.sendCommand(ControllerCommands.nextFile);
        break;
      case 'fast_forward':
        _serverController.sendCommand(ControllerCommands.jumpForward(_settingsController.jumpDistance.value));
        break;
    }
  }

  void _handleDeviceVolumesKey(double? volume) async {
    if (volume == null || _serverController.selected.mediaStatus?.volume.value == null) return;
    final int deviceVolume = (volume * 100).round();
    final int volumeMedia = (_serverController.selected.mediaStatus!.volume.value / 100).round();
    final int newVolume = deviceVolume + volumeMedia;

    _serverController.sendCommand(ControllerCommands.volume, volume: newVolume);
  }

  void _handlerCalls(CallState? event) {
    switch (event) {
      case CallState.CALL_ENDED:
        if (_settingsController.afterCallEnd.value) {
          _serverController.sendCommand(ControllerCommands.play);
        }
        break;
      case CallState.CALL_STARTED:
        if (_settingsController.incomingCall.value) {
          _serverController.sendCommand(ControllerCommands.pause);
        }
        break;
      case CallState.CALL_INCOMING:
        if (_settingsController.incomingCall.value) {
          _serverController.sendCommand(ControllerCommands.pause);
        }
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: _appTheme,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: AppRoute.routes,
    );
  }
}
