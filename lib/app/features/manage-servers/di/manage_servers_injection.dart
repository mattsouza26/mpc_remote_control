import 'package:get_it/get_it.dart';

import '../../../core/services/http_client/http_client_service.dart';
import '../../../core/services/local_storage/local_storage_service.dart';
import '../../../core/services/network/network_service.dart';
import '../data/data_source/manage_server_network_datasource.dart';
import '../data/data_source/manage_servers_storage_datasource.dart';
import '../data/repositories/manage_servers_network_repository_impl.dart';
import '../data/repositories/manage_servers_storage_repository_impl.dart';
import '../domain/repositories/manage_servers_network_repository.dart';
import '../domain/repositories/manage_servers_storage_repository.dart';
import '../domain/usecases/delete_manage_server_usecase.dart';
import '../domain/usecases/discover_servers_usecase.dart';
import '../domain/usecases/edit_manage_server_usecase.dart';
import '../domain/usecases/load_manage_servers_usecase.dart';
import '../domain/usecases/save_manage_server_usecase.dart';
import '../presentation/repositories/manage_servers_repository.dart';
import '../presentation/store/manage_servers_store.dart';

class ManageServersInjection {
  final _getIt = GetIt.instance;

  Future<void> init() async {
    //datasources & repositories
    _getIt.registerLazySingleton<ManageServersStorageDataSource>(() => ManageServersStorageDataSourceImpl(_getIt.get<LocalStorageService>()));
    _getIt.registerLazySingleton<ManageServersStorageRepository>(() => ManageServersStorageRepositoryImpl(_getIt.get<ManageServersStorageDataSource>()));
    _getIt.registerLazySingleton<ManageServersNetworkDataSource>(
      () => ManageServersNetworkDataSourceImpl(
        _getIt.get<NetworkService>(),
        _getIt.get<HttpClientService>(),
      ),
    );
    _getIt.registerLazySingleton<ManageServersNetworkRepository>(() => ManageServersNetworkRepositoryImpl(_getIt.get<ManageServersNetworkDataSource>()));

    //usecases
    _getIt.registerFactory<LoadManageServersUseCase>(() => LoadManageServersUseCaseImpl(_getIt.get<ManageServersStorageRepository>()));
    _getIt.registerFactory<SaveManageServerUseCase>(() => SaveManageServerUseCaseImpl(_getIt.get<ManageServersStorageRepository>()));
    _getIt.registerFactory<DeleteManageServerUseCase>(() => DeleteManageServerUseCaseImpl(_getIt.get<ManageServersStorageRepository>()));
    _getIt.registerFactory<EditManageServerUseCase>(() => EditManageServerUseCaseImpl(_getIt.get<ManageServersStorageRepository>()));
    _getIt.registerFactory<DiscoverServerUseCase>(() => DiscoverServerUseCaseImpl(_getIt.get<ManageServersNetworkRepository>()));

    //repositories & stores
    _getIt.registerLazySingleton<ManageServersRepository>(
      () => ManageServersRepository(
        _getIt.get<LoadManageServersUseCase>(),
        _getIt.get<SaveManageServerUseCase>(),
        _getIt.get<EditManageServerUseCase>(),
        _getIt.get<DeleteManageServerUseCase>(),
        _getIt.get<DiscoverServerUseCase>(),
      ),
    );
    _getIt.registerLazySingleton(() => ManageServersStore(_getIt.get<ManageServersRepository>()));
  }
}
