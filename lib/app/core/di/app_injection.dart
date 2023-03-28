import 'package:mpc_remote_control/app/core/services/device_handler/di/device_handler_injection.dart';

import '../../features/file_browser/di/file_browser_injection.dart';
import '../../features/manage-servers/di/manage_servers_injection.dart';
import '../../features/server/di/server_injection.dart';
import '../../features/settings/di/settings_injection.dart';
import '../services/http_client/di/http_client_injection.dart';
import '../services/local_notifications/di/local_notification_injection.dart';
import '../services/local_storage/di/local_storage_injection.dart';
import '../services/network/di/network_injection.dart';

class AppInjection {
  Future<void> init() async {
    // Services
    await Future.wait([
      LocalStorageInjection().init(),
      HttpClientInjection().init(),
      LocalNotificationInjection().init(),
      NetworkInjection().init(),
      DeviceHandlerInjection().init(),
    ]);

    //features
    await Future.wait([
      SettingsInjection().init(),
      ServerInjection().init(),
      ManageServersInjection().init(),
      FileBrowserInjection().init(),
    ]);
  }
}
