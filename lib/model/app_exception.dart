class AppException implements Exception {
  String? title;
  String? message;

  AppException([this.title, this.message]);

  @override
  String toString() {
    return 'AppException: message: $message, title: $title';
  }
}
