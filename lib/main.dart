import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app/app.dart';
import 'app/core/di/app_injection.dart';
import 'app/core/services/local_notifications/models/notification_response.dart';

final ReceivePort _receivePort = ReceivePort();
final Stream _receiveStream = _receivePort.asBroadcastStream();
final Stream<LocalNotificationResponse?> onNotificationReceive = _receiveStream.map((event) {
  if (event is TransferableTypedData) {
    final buffer = event.materialize().asUint8List();
    final responseJson = utf8.decode(buffer);
    final responseNotification = LocalNotificationResponse.fromJson(json.decode(responseJson));

    return responseNotification;
  }
}).asBroadcastStream();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  IsolateNameServer.removePortNameMapping('main-app');
  IsolateNameServer.registerPortWithName(_receivePort.sendPort, 'main-app');

  await AppInjection().init();

  runApp(const App());
  FlutterNativeSplash.remove();
}
