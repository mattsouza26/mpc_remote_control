import 'package:result_dart/result_dart.dart';

import '../../../../core/services/local_notifications/errors/local_notification_exception.dart';
import '../repositories/server_notification_repository.dart';

abstract class CancelMediaNotificationUseCase {
  Future<Result<void, LocalNotificationException>> call();
}

class CancelMediaNotificationUseCaseImpl implements CancelMediaNotificationUseCase {
  final ServerNotificationRepository _repository;

  CancelMediaNotificationUseCaseImpl(this._repository);
  @override
  Future<Result<void, LocalNotificationException>> call() {
    return _repository.cancelMediaNotification();
  }
}
