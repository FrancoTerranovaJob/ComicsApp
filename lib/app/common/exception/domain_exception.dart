class DomainException implements Exception {
  final String message;
  final String code;

  DomainException({required this.message, required this.code});
}