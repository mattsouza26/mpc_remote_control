import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import 'errors/http_client_exception.dart';
import 'models/http_response.dart';

abstract class HttpClientService {
  Future<HttpClientResponse> get<T>(String url, {Duration timeout = const Duration(seconds: 60)});
  Future<HttpClientResponse> post<T>(String url, {Duration timeout = const Duration(seconds: 60)});
}

class DioServiceImpl implements HttpClientService {
  final Dio _dio;

  DioServiceImpl(this._dio);

  @override
  Future<HttpClientResponse> get<T>(String url, {Duration timeout = const Duration(seconds: 5)}) async {
    try {
      _dio.options.connectTimeout = timeout;
      final response = await _dio.get(url);

      return HttpClientResponse(statusCode: response.statusCode, data: response.data, statusMessage: response.statusMessage);
    } on TimeoutException catch (e) {
      throw HttpClientException(e.toString());
    } on SocketException catch (e) {
      throw HttpClientException(e.message);
    } on DioError catch (e) {
      throw HttpClientException(e.message);
    } catch (e) {
      throw HttpClientException(e.toString());
    }
  }

  @override
  Future<HttpClientResponse> post<T>(String url, {Duration timeout = const Duration(seconds: 5)}) async {
    try {
      _dio.options.connectTimeout = timeout;
      final response = await _dio.post(url);
      return HttpClientResponse(statusCode: response.statusCode, data: response.data, statusMessage: response.statusMessage);
    } on TimeoutException catch (e) {
      throw HttpClientException(e.toString());
    } on SocketException catch (e) {
      throw HttpClientException(e.message);
    } on DioError catch (e) {
      throw HttpClientException(e.message);
    }
  }
}
