import 'package:get_it/get_it.dart';
import 'package:mpc_remote_control/app/core/services/device_handler/device_handler_service.dart';
import 'package:mpc_remote_control/app/features/server/domain/usecases/check_server_usecase.dart';

import '../../../core/services/http_client/http_client_service.dart';
import '../../../core/services/local_notifications/local_notification_service.dart';
import '../data/data_source/server_datasource.dart';
import '../data/data_source/server_notification_datasource.dart';
import '../data/repositories/server_notification_repository_impl.dart';
import '../data/repositories/server_repository_impl.dart';
import '../domain/repositories/server_notification_repository.dart';
import '../domain/repositories/server_repository.dart';
import '../domain/usecases/cancel_media_notification_usecase.dart';
import '../domain/usecases/get_media_status_usecase.dart';
import '../domain/usecases/send_command_usecase.dart';
import '../domain/usecases/show_media_notification_usecase.dart';
import '../presentation/controller/server_controller.dart';

class ServerInjection {
  final _getIt = GetIt.instance;

  Future<void> init() async {
    //datasources & repositories
    _getIt.registerLazySingleton<ServerDataSource>(() => ServerDataSourceImpl(_getIt.get<HttpClientService>()));
    _getIt.registerLazySingleton<ServerRepository>(() => ServerRepositoryImpl(_getIt.get<ServerDataSource>()));

    _getIt.registerLazySingleton<ServerNotificationDataSource>(
        () => ServerNotificationDataSourceImpl(_getIt.get<LocalNotificationService>(), _getIt.get<DeviceHandlerService>()));
    _getIt.registerLazySingleton<ServerNotificationRepository>(() => ServerNotificationRepositoryImpl(_getIt.get<ServerNotificationDataSource>()));

    //usecases
    _getIt.registerFactory<SendCommandUseCase>(() => SendCommandUseCaseImpl(_getIt.get<ServerRepository>()));
    _getIt.registerFactory<GetMediaStatusUseCase>(() => GetMediaStatusUseCaseImpl(_getIt.get<ServerRepository>()));
    _getIt.registerFactory<CheckServerUseCase>(() => CheckServerUseCaseImpl(_getIt.get<ServerRepository>()));
    _getIt.registerFactory<ShowMediaNotificationUseCase>(() => ShowMediaNotificationUseCaseImpl(_getIt.get<ServerNotificationRepository>()));
    _getIt.registerFactory<CancelMediaNotificationUseCase>(() => CancelMediaNotificationUseCaseImpl(_getIt.get<ServerNotificationRepository>()));

    //controller
    _getIt.registerSingleton<ServerController>(
      ServerController(
        _getIt.get<SendCommandUseCase>(),
        _getIt.get<GetMediaStatusUseCase>(),
        _getIt.get<CheckServerUseCase>(),
        _getIt.get<ShowMediaNotificationUseCase>(),
        _getIt.get<CancelMediaNotificationUseCase>(),
      ),
    );
  }
}
