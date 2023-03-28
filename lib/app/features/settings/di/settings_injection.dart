import 'package:get_it/get_it.dart';

import '../../../core/services/local_storage/local_storage_service.dart';
import '../../../core/services/network/network_service.dart';
import '../data/data_source/settings_network_datasource.dart';
import '../data/data_source/settings_storage_datasource.dart';
import '../data/repositories/settings_netwokr_repository_impl.dart';
import '../data/repositories/settings_storage_repository_impl.dart';
import '../domain/repositories/settings_network_repository.dart';
import '../domain/repositories/settings_storage_repository.dart';
import '../domain/usecases/delete_settings_usecase.dart';
import '../domain/usecases/get_subnet_usecase.dart';
import '../domain/usecases/load_settings_usecase.dart';
import '../domain/usecases/save_settings_usecase.dart';
import '../presentation/controller/settings_controller.dart';

class SettingsInjection {
  final GetIt _getIt = GetIt.instance;

  Future<void> init() async {
    await _getIt.isReady<LocalStorageService>();

    //datasource & repositories
    _getIt.registerLazySingleton<SettingsStorageDataSource>(() => SettingsStorageDataSourceImpl(_getIt.get<LocalStorageService>()));
    _getIt.registerLazySingleton<SettingsStorageRepository>(() => SettingsStorageRepositoryImpl(_getIt.get<SettingsStorageDataSource>()));
    _getIt.registerLazySingleton<SettingsNetworkDataSouce>(() => SettingsNetworkDataSouceImpl(_getIt.get<NetworkService>()));
    _getIt.registerLazySingleton<SettingsNetworkRepository>(() => SettingsNetworkRepositoryImpl(_getIt.get<SettingsNetworkDataSouce>()));
    //usecases
    _getIt.registerFactory<LoadSettingsUseCase>(() => LoadSettingsUseCaseImpl(_getIt.get<SettingsStorageRepository>()));
    _getIt.registerFactory<SaveSettingsUseCase>(() => SaveSettingsUseCaseImpl(_getIt.get<SettingsStorageRepository>()));
    _getIt.registerFactory<DeleteSettingsUseCase>(() => DeleteSettingsUseCaseImpl(_getIt.get<SettingsStorageRepository>()));
    _getIt.registerFactory<GetSubnetUseCase>(() => GetSubnetUseCaseImpl(_getIt.get<SettingsNetworkRepository>()));

    //Controller
    _getIt.registerSingletonAsync<SettingsController>(() async {
      final settingsController = SettingsController(
        _getIt.get<LoadSettingsUseCase>(),
        _getIt.get<SaveSettingsUseCase>(),
        _getIt.get<DeleteSettingsUseCase>(),
        _getIt.get<GetSubnetUseCase>(),
      );
      await settingsController.init();
      return settingsController;
    });

    await _getIt.isReady<SettingsController>();
  }
}
