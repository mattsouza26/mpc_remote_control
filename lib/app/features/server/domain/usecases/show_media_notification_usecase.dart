import 'package:mpc_remote_control/app/core/services/local_notifications/errors/local_notification_exception.dart';
import 'package:result_dart/result_dart.dart';

import '../repositories/server_notification_repository.dart';

abstract class ShowMediaNotificationUseCase {
  Future<Result<void, LocalNotificationException>> call([String? title, bool? isReproducing]);
}

class ShowMediaNotificationUseCaseImpl implements ShowMediaNotificationUseCase {
  final ServerNotificationRepository _repository;

  ShowMediaNotificationUseCaseImpl(this._repository);
  @override
  Future<Result<void, LocalNotificationException>> call([String? title, bool? isReproducing]) {
    return _repository.showMediaNotification(title, isReproducing);
  }
}
