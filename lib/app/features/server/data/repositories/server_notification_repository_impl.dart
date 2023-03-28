import 'package:mpc_remote_control/app/core/services/local_notifications/errors/local_notification_exception.dart';
import 'package:result_dart/result_dart.dart';

import '../../domain/repositories/server_notification_repository.dart';
import '../data_source/server_notification_datasource.dart';

class ServerNotificationRepositoryImpl implements ServerNotificationRepository {
  final ServerNotificationDataSource _dataSource;

  ServerNotificationRepositoryImpl(this._dataSource);

  @override
  Future<Result<void, LocalNotificationException>> cancelMediaNotification() async {
    try {
      await _dataSource.cancelMediaNotification();
      return const Success(Unit);
    } catch (e) {
      return Failure(LocalNotificationException(e.toString()));
    }
  }

  @override
  Future<Result<void, LocalNotificationException>> showMediaNotification([String? title, bool? isReproducing]) async {
    try {
      await _dataSource.showMediaNotification(title, isReproducing);
      return const Success(Unit);
    } catch (e) {
      return Failure(LocalNotificationException(e.toString()));
    }
  }
}
