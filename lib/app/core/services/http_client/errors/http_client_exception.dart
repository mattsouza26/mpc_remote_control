class HttpClientException {
  final String? error;
  HttpClientException([this.error]);

  @override
  String toString() {
    return "Instance of HttpClientException(error: $error)";
  }
}
