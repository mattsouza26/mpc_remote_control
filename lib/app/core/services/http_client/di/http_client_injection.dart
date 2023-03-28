import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../http_client_service.dart';

class HttpClientInjection {
  final GetIt _getIt = GetIt.instance;
  Future<void> init() async {
    _getIt.registerFactory<Dio>(() => Dio());
    _getIt.registerFactory<HttpClientService>(() => DioServiceImpl(_getIt.get<Dio>()));
  }
}
