import 'package:get_it/get_it.dart';

import '../../../core/services/http_client/http_client_service.dart';
import '../data/data_source/browser_datasource.dart';
import '../data/repositories/browser_repository_impl.dart';
import '../domain/repositories/browser_repository.dart';
import '../domain/usecases/get_files_usecase.dart';
import '../domain/usecases/open_file_usecase.dart';
import '../domain/usecases/open_folder_usecase.dart';
import '../presentation/repository/file_browser_repository.dart';
import '../presentation/store/file_browser_store.dart';

class FileBrowserInjection {
  final _getIt = GetIt.instance;

  Future<void> init() async {
    //datasources & repositories
    _getIt.registerLazySingleton<BrowserDataSource>(() => BrowserDataSourceImpl(_getIt.get<HttpClientService>()));
    _getIt.registerLazySingleton<BrowserRepository>(() => BrowserRepositoryImpl(_getIt.get<BrowserDataSource>()));

    //usecases
    _getIt.registerFactory<GetFilesUseCase>(() => GetFilesUseCaseImpl(_getIt.get<BrowserRepository>()));
    _getIt.registerFactory<OpenFolderUseCase>(() => OpenFolderUseCaseImpl(_getIt.get<BrowserRepository>()));
    _getIt.registerFactory<OpenFileUseCase>(() => OpenFileUseCaseImpl(_getIt.get<BrowserRepository>()));

    //repository and store
    _getIt.registerLazySingleton<FileBrowserRepository>(
      () => FileBrowserRepository(
        _getIt.get<GetFilesUseCase>(),
        _getIt.get<OpenFolderUseCase>(),
        _getIt.get<OpenFileUseCase>(),
      ),
    );
    _getIt.registerLazySingleton(() => FileBrowserStore(_getIt.get<FileBrowserRepository>()));
  }
}
