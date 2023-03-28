import 'package:result_dart/result_dart.dart';

import '../../../../core/services/local_notifications/errors/local_notification_exception.dart';

abstract class ServerNotificationRepository {
  Future<Result<void, LocalNotificationException>> showMediaNotification(String? title, bool? isReproducing);
  Future<Result<void, LocalNotificationException>> cancelMediaNotification();
}
