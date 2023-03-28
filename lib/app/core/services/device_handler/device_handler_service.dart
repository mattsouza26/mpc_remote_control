import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';
import 'package:volume_controller/volume_controller.dart';
import 'enums/call_event.dart';

abstract class DeviceHandlerService {
  Future<bool> requestNotificationPermission();
  Future<bool> requestPhonePermission();
  Future<void> enableScreenOn();
  Future<void> disableScreenOn();
  Future<void> setVolume(double volume);
  Future<double> getVolume();
  Future<void> volumeListener(void Function(double volume) listener);
  Future<void> removeVolumeListener(void Function(double volume) listener);
  Future<void> callsListener(void Function(CallState? event) listener);
  Future<void> removeCallsListener(void Function(CallState? event) listener);
}

class DeviceHandlerServiceImpl implements DeviceHandlerService {
  final VolumeController _volumeController = VolumeController();
  final Stream<PhoneStateStatus?> _callStream = PhoneState.phoneStateStream;

  final List<void Function(double volume)> _volumeListeners = [];
  final List<void Function(CallState? event)> _callsListeners = [];

  DeviceHandlerServiceImpl() {
    _init();
  }

  Future<void> _init() async {
    _volumeController.listener(_volumeHandler);
    _callStream.listen(_callsHandler);
  }

  @override
  Future<double> getVolume() async {
    return await _volumeController.getVolume();
  }

  @override
  Future<void> setVolume(double volume) async {
    _volumeController.setVolume(volume, showSystemUI: true);
  }

  @override
  Future<void> volumeListener(void Function(double volume) listener) async {
    if (_volumeListeners.contains(listener)) return;
    _volumeListeners.add(listener);
  }

  @override
  Future<void> removeVolumeListener(void Function(double volume) listener) async {
    if (!_volumeListeners.contains(listener)) return;
    _volumeListeners.remove(listener);
  }

  _volumeHandler(double volume) {
    for (var callback in _volumeListeners) {
      callback.call(volume);
    }
  }

  _callsHandler(PhoneStateStatus? callEvent) {
    for (var callback in _callsListeners) {
      CallState event;
      switch (callEvent) {
        case PhoneStateStatus.CALL_ENDED:
          event = CallState.CALL_ENDED;
          break;
        case PhoneStateStatus.CALL_INCOMING:
          event = CallState.CALL_INCOMING;
          break;
        case PhoneStateStatus.CALL_STARTED:
          event = CallState.CALL_STARTED;
          break;
        default:
          event = CallState.NOTHING;
          break;
      }
      callback.call(event);
    }
  }

  @override
  Future<void> callsListener(void Function(CallState? event) listener) async {
    if (_callsListeners.contains(listener)) return;
    _callsListeners.add(listener);
  }

  @override
  Future<void> removeCallsListener(void Function(CallState? event) listener) async {
    if (!_callsListeners.contains(listener)) return;
    _callsListeners.remove(listener);
  }

  @override
  Future<bool> requestNotificationPermission() async {
    final result = await Permission.notification.request();
    return result.isGranted ? true : false;
  }

  @override
  Future<bool> requestPhonePermission() async {
    final result = await Permission.phone.request();
    return result.isGranted ? true : false;
  }

  @override
  Future<void> disableScreenOn() async {
    await KeepScreenOn.turnOn();
  }

  @override
  Future<void> enableScreenOn() async {
    await KeepScreenOn.turnOff();
  }
}
