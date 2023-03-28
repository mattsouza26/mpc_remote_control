import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mpc_remote_control/app/core/services/local_notifications/errors/local_notification_exception.dart';
import 'package:path_provider/path_provider.dart';

import 'models/notification_response.dart';

abstract class LocalNotificationService {
  Future<void> defaultConfiguration();
  Future<void> configure(Map<String, dynamic> configuration, {List<Map<String, dynamic>>? actions});
  Future<void> startForeground({required int id, String? title, String? body, Map<String, dynamic>? payload, int? startType, Set<int>? foregroundServiceTypes});
  Future<void> cancelForeground();
  Future<void> showNotification({required int id, String? title, String? body, Map<String, dynamic>? payload});
  Future<void> cancelNotification(int id);
  Future<void> cancelAllNotification();
}

class LocalNotificationServiceImpl implements LocalNotificationService {
  final _localNotificationPlugin = AndroidFlutterLocalNotificationsPlugin();
  late AndroidNotificationDetails _androidConfiguration;
  final String _defaultChannelId = "main_channel";
  final String _defaultChannelName = "Main Channel";

  LocalNotificationServiceImpl() {
    _init();
  }

  Future<void> _init() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_notification');
    await _localNotificationPlugin.initialize(
      initializationSettingsAndroid,
      onDidReceiveBackgroundNotificationResponse: _onDidReceiveBackgroundNotificationResponse,
    );
    _localNotificationPlugin.createNotificationChannel(const AndroidNotificationChannel('main_channel', 'Main Channel'));
    _localNotificationPlugin.createNotificationChannel(const AndroidNotificationChannel('media_channel', 'Media Channel'));
    await defaultConfiguration();
  }

  @pragma('vm:entry-point')
  static void _onDidReceiveBackgroundNotificationResponse(NotificationResponse notificationResponse) async {
    final sendPort = IsolateNameServer.lookupPortByName('main-app');
    final localNotificationResponse = LocalNotificationResponse(
      id: notificationResponse.id,
      actionId: notificationResponse.actionId,
      input: notificationResponse.input,
      notificationResponseType: notificationResponse.notificationResponseType.toString(),
      payload: {
        'default': notificationResponse.payload,
      },
    );

    sendPort?.send(localNotificationResponse.toTransferableTypeData());
  }

  @override
  Future<void> defaultConfiguration() async {
    configure({});
  }

  @override
  Future<void> configure(Map<String, dynamic> configuration, {List<Map<String, dynamic>>? actions}) async {
    try {
      _androidConfiguration = await _createAndroidConfig(configuration, actions);
    } catch (e) {
      LocalNotificationException(e.toString());
    }
  }

  @override
  Future<void> showNotification({required int id, String? title, String? body, Map<String, dynamic>? payload}) async {
    try {
      await _localNotificationPlugin.requestPermission();
      await _localNotificationPlugin.show(
        id,
        title,
        body,
        notificationDetails: _androidConfiguration,
        payload: payload?.values.first,
      );
    } catch (e) {
      LocalNotificationException(e.toString());
    }
  }

  @override
  Future<void> startForeground({
    required int id,
    String? title,
    String? body,
    Map<String, dynamic>? payload,
    int? startType,
    Set<int>? foregroundServiceTypes,
  }) async {
    try {
      await _localNotificationPlugin.requestPermission();
      await _localNotificationPlugin.startForegroundService(
        id,
        title,
        body,
        payload: payload?.values.first,
        notificationDetails: _androidConfiguration,
        startType: AndroidServiceStartType(startType ?? 1),
        foregroundServiceTypes: foregroundServiceTypes?.map((type) => AndroidServiceForegroundType(type)).toSet(),
      );
    } catch (e) {
      LocalNotificationException(e.toString());
    }
  }

  @override
  Future<void> cancelNotification(int id) async {
    try {
      await _localNotificationPlugin.cancel(id);
    } catch (e) {
      LocalNotificationException(e.toString());
    }
  }

  @override
  Future<void> cancelAllNotification() async {
    try {
      await _localNotificationPlugin.cancelAll();
    } catch (e) {
      LocalNotificationException(e.toString());
    }
  }

  @override
  Future<void> cancelForeground() async {
    try {
      await _localNotificationPlugin.stopForegroundService();
    } catch (e) {
      LocalNotificationException(e.toString());
    }
  }

  Future<AndroidNotificationDetails> _createAndroidConfig(Map<String, dynamic> map, List<Map<String, dynamic>>? actions) async {
    return AndroidNotificationDetails(
      map['channelId'] is String ? map['channelId'] : _defaultChannelId,
      map['channelName'] is String ? map['channelName'] : _defaultChannelName,
      channelDescription: map['channelDescription'] is String ? map['channelDescription'] : null,
      icon: map['icon'] is String ? map['icon'] : null,
      importance: map['importance'] is String ? map['importance'] : Importance.defaultImportance,
      priority: map['priority'] is String ? map['priority'] : Priority.high,
      styleInformation: map['styleInformation'] is StyleInformation ? map['styleInformation'] : const DefaultStyleInformation(true, true),
      playSound: map['playSound'] is bool ? map['playSound'] : false,
      sound: map['sound'] is AndroidNotificationSound ? map['sound'] : null,
      enableVibration: map['enableVibration'] is bool ? map['enableVibration'] : false,
      vibrationPattern: map['vibrationPattern'] is Int64List ? map['vibrationPattern'] : null,
      groupKey: map['groupKey'] is String ? map['groupKey'] : null,
      setAsGroupSummary: map['setAsGroupSummary'] is bool ? map['setAsGroupSummary'] : false,
      autoCancel: map['autoCancel'] is bool ? map['autoCancel'] : true,
      ongoing: map['ongoing'] is bool ? map['ongoing'] : false,
      color: map['color'] is Color ? map['color'] : null,
      largeIcon: map['largeIcon'] is AndroidBitmap<Object> ? map['largeIcon'] : null,
      onlyAlertOnce: map['onlyAlertOnce'] is bool ? map['onlyAlertOnce'] : false,
      showWhen: map['showWhen'] is bool ? map['showWhen'] : true,
      when: map['when'] is int ? map['when'] : null,
      usesChronometer: map['usesChronometer'] is bool ? map['usesChronometer'] : false,
      chronometerCountDown: map['chronometerCountDown'] is bool ? map['chronometerCountDown'] : false,
      channelShowBadge: map['channelShowBadge'] is bool ? map['channelShowBadge'] : true,
      showProgress: map['showProgress'] is bool ? map['showProgress'] : false,
      maxProgress: map['maxProgress'] is int ? map['maxProgress'] : 0,
      progress: map['progress'] is int ? map['progress'] : 0,
      indeterminate: map['indeterminate'] is bool ? map['indeterminate'] : false,
      channelAction: map['channelAction'] is AndroidNotificationChannelAction ? map['channelAction'] : AndroidNotificationChannelAction.createIfNotExists,
      enableLights: map['enableLights'] is bool ? map['enableLights'] : false,
      ledColor: map['ledColor'] is Color ? map['ledColor'] : null,
      ledOnMs: map['ledOnMs'] is int ? map['ledOnMs'] : null,
      ledOffMs: map['ledOffMs'] is int ? map['ledOffMs'] : null,
      ticker: map['ticker'] is String ? map['ticker'] : null,
      visibility: map['visibility'] is NotificationVisibility ? map['visibility'] : null,
      timeoutAfter: map['timeoutAfter'] is int ? map['timeoutAfter'] : null,
      category: map['category'] is AndroidNotificationCategory ? map['category'] : null,
      fullScreenIntent: map['fullScreenIntent'] is bool ? map['fullScreenIntent'] : false,
      shortcutId: map['shortcutId'] is String ? map['shortcutId'] : null,
      additionalFlags: map['additionalFlags'] is Int32List ? map['additionalFlags'] : null,
      subText: map['subText'] is String ? map['subText'] : null,
      tag: map['tag'] is String ? map['tag'] : null,
      colorized: map['colorized'] is bool ? map['colorized'] : false,
      number: map['number'] is int ? map['number'] : null,
      audioAttributesUsage: map['audioAttributesUsage'] is AudioAttributesUsage ? map['audioAttributesUsage'] : AudioAttributesUsage.notification,
      actions: await _createAndroidAction(actions),
    );
  }

  Future<List<AndroidNotificationAction>> _createAndroidAction(List<Map<String, dynamic>>? actions) async {
    final List<AndroidNotificationAction> androidActionsButton = [];
    for (Map<String, dynamic> action in actions ?? []) {
      if (action['id'] is String && action['title'] is String && action['icon'] is String) {
        final filepath = await _copyImageFromAssetsToAppDir(action['icon']);
        androidActionsButton.add(
          AndroidNotificationAction(
            action['id'] as String,
            action['title'] as String,
            icon: FilePathAndroidBitmap(filepath),
            showsUserInterface: action['showsUserInterface'] is bool ? action['showsUserInterface'] : false,
            contextual: action['contextual'] is bool ? action['contextual'] : false,
            allowGeneratedReplies: action['allowGeneratedReplies'] is bool ? action['allowGeneratedReplies'] : false,
            titleColor: action['titleColor'] is bool ? action['titleColor'] : null,
            cancelNotification: action['cancelNotification'] is bool ? action['cancelNotification'] : true,
          ),
        );
      }
    }
    return androidActionsButton;
  }

  Future<String> _copyImageFromAssetsToAppDir(String fileName) async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json').then<Map<String, dynamic>>((value) => jsonDecode(value));

    final assetFile = manifestContent.keys.singleWhere((key) => key.contains(fileName));
    final extension = assetFile.substring(assetFile.lastIndexOf('.'));
    final dir = await getApplicationDocumentsDirectory();
    final path = "${dir.path}/$fileName$extension";
    final file = File(path);
    if (await file.exists()) {
      return path;
    }
    final imageBytes = await rootBundle.load('lib/app/core/assets/images/notification/$fileName');
    final bytes = imageBytes.buffer.asUint8List();
    await file.writeAsBytes(bytes);
    return path;
  }
}
