import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mpc_remote_control/app/core/services/device_handler/device_handler_service.dart';

import '../../../../core/services/local_notifications/errors/local_notification_exception.dart';
import '../../../../core/services/local_notifications/local_notification_service.dart';

abstract class ServerNotificationDataSource {
  Future<void> showMediaNotification(String? title, bool? isReproducing);
  Future<void> cancelMediaNotification();
}

class ServerNotificationDataSourceImpl implements ServerNotificationDataSource {
  final LocalNotificationService _notificationService;
  final DeviceHandlerService _handlerService;
  ServerNotificationDataSourceImpl(this._notificationService, this._handlerService);

  final int mediaNotificationId = 50;

  @override
  Future<void> cancelMediaNotification() async {
    try {
      await _notificationService.cancelForeground();
    } catch (e) {
      throw const LocalNotificationException('Notification not found!');
    }
  }

  @override
  Future<void> showMediaNotification(String? title, bool? isReproducing) async {
    try {
      await _handlerService.requestNotificationPermission();
      await _mediaNotificationConfiguration(isReproducing);
      await _notificationService.startForeground(
        id: mediaNotificationId,
        title: title ?? 'MPC Remote Control',
        foregroundServiceTypes: {
          2,
        },
      );
    } catch (e) {
      throw const LocalNotificationException("Couldn't show notification, check your permissions!");
    }
  }

  Future<void> _mediaNotificationConfiguration(bool? isReproducing) async {
    try {
      await _notificationService.configure(
        {
          'channelId': "media_channel",
          'channelName': "Media Channel",
          'styleInformation': const MediaStyleInformation(htmlFormatContent: true, htmlFormatTitle: true),
          'autoCancel': false,
          'onlyAlertOnce': true,
          'playSound': false,
          'ongoing': true,
        },
        actions: isReproducing == null
            ? null
            : [
                _createAction(
                  id: 'fast_rewind',
                  title: 'Fast Rewind',
                  icon: 'service_fast_rewind.png',
                  showsUserInterface: false,
                  cancelNotification: false,
                ),
                _createAction(
                  id: 'skip_previous',
                  title: 'Skip Previous',
                  icon: 'service_skip_previous.png',
                  showsUserInterface: false,
                  cancelNotification: false,
                ),
                if (isReproducing)
                  _createAction(
                    id: 'pause',
                    title: 'Pause',
                    icon: 'service_pause.png',
                    showsUserInterface: false,
                    cancelNotification: false,
                  )
                else
                  _createAction(
                    id: 'play',
                    title: 'Play',
                    icon: 'service_play_arrow.png',
                    showsUserInterface: false,
                    cancelNotification: false,
                  ),
                _createAction(
                  id: 'skip_next',
                  title: 'Skip Next',
                  icon: 'service_skip_next.png',
                  showsUserInterface: false,
                  cancelNotification: false,
                ),
                _createAction(
                  id: 'fast_forward',
                  title: 'Fast Forward',
                  icon: 'service_fast_forward.png',
                  showsUserInterface: false,
                  cancelNotification: false,
                ),
              ],
      );
    } catch (e) {
      throw const LocalNotificationException("Couldn't show notification, check your permissions!");
    }
  }

  Map<String, dynamic> _createAction({
    required String id,
    required String title,
    required String icon,
    bool? showsUserInterface,
    bool? cancelNotification,
    bool? contextual,
    Color? titleColor,
  }) {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'showsUserInterface': showsUserInterface,
      'cancelNotification': cancelNotification,
      'contextual': contextual,
      'titleColor': titleColor,
    };
  }
}
