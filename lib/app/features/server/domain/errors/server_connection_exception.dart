class ServerException {
  final String? error;
  const ServerException([this.error]);

  @override
  String toString() {
    return "Instance of ServerException(error: $error)";
  }
}
