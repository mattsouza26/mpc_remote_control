// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HttpClientResponse {
  final int? statusCode;
  final String? statusMessage;
  final Object? data;

  const HttpClientResponse({
    this.statusCode,
    this.statusMessage,
    this.data,
  });
  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
