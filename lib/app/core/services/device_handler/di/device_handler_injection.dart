import 'package:get_it/get_it.dart';
import 'package:mpc_remote_control/app/core/services/device_handler/device_handler_service.dart';

class DeviceHandlerInjection {
  final GetIt _getIt = GetIt.instance;
  Future<void> init() async {
    _getIt.registerLazySingleton<DeviceHandlerService>(() => DeviceHandlerServiceImpl());
  }
}
