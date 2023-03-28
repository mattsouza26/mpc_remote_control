import 'package:get_it/get_it.dart';

import '../local_notification_service.dart';

class LocalNotificationInjection {
  final GetIt _getIt = GetIt.instance;
  Future<void> init() async {
    _getIt.registerLazySingleton<LocalNotificationService>(() => LocalNotificationServiceImpl());
  }
}
