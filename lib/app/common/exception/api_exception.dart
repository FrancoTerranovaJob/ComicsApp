class ApiException implements Exception {
  final String message;
  final String code;

  ApiException({required this.message, required this.code});
}