class HttpRequest implements Exception {
  final String message;
  HttpRequest(
    this.message,
  );

  @override
  String toString() {
    return message;
  }
}
