import 'package:comics_app/app/common/exception/domain_exception.dart';

class HttpApiException extends DomainException {
  HttpApiException({required super.message, required super.code});
}

class ComicsApiProviderException extends DomainException {
  ComicsApiProviderException({required super.message, required super.code});
}

class ComicsRepositoryException extends DomainException {
  ComicsRepositoryException({required super.message, required super.code});
}