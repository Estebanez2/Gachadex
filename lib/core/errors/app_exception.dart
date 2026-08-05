class AppException implements Exception {
  const AppException({required this.code, this.safeMessage, this.cause});

  final String code;
  final String? safeMessage;
  final Object? cause;

  @override
  String toString() => 'AppException(code: $code)';
}
