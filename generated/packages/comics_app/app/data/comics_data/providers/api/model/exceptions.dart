import 'package:comics_app/app/common/exception/api_exception.dart';

class DioException extends ApiException {
  DioException({required super.message, required super.code, super.body});

  @override
  String toString() {
    return '$body - $message, $code.';
  }
}

class GetComicsException extends ApiException {
  GetComicsException({required super.message, required super.code, super.body});
}

class GetComicDetailException extends ApiException {
  GetComicDetailException(
      {required super.message, required super.code, super.body});
}