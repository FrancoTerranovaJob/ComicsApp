class DomainException implements Exception {
  final Object? message;
  final String code;

  DomainException({required this.message, required this.code});
}