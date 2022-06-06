import 'package:comics_app/app/common/exception/domain_exception.dart';

class HttpApiException extends DomainException {
  HttpApiException({required super.message, required super.code});
}

class ComicsApiProviderException extends DomainException {
  ComicsApiProviderException({required super.message, required super.code});
}

class ComicsRepositoryGetComicsException extends DomainException {
  ComicsRepositoryGetComicsException(
      {required super.message, required super.code});
}

class ComicsRepositoryLoadMoreComicsException extends DomainException {
  ComicsRepositoryLoadMoreComicsException(
      {required super.message, required super.code});
}