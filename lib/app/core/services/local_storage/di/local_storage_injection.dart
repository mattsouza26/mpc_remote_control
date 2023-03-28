import 'package:get_it/get_it.dart';

import '../local_storage_service.dart';

class LocalStorageInjection {
  final GetIt _getIt = GetIt.instance;
  Future<void> init() async {
    _getIt.registerSingletonAsync<LocalStorageService>(() async => await HiveLocalStorageService().init());
  }
}
