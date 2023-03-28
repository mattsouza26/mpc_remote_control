import 'package:get_it/get_it.dart';

import '../network_service.dart';

class NetworkInjection {
  final GetIt _getIt = GetIt.instance;
  Future<void> init() async {
    _getIt.registerFactory<NetworkService>(() => NetworkServiceImpl());
  }
}
