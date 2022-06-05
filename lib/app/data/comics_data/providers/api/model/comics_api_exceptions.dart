import 'package:comics_app/app/common/exception/api_exception.dart';

class DioException extends ApiException {
  DioException({required super.message, required super.code, super.body});

  @override
  String toString() {
    return '$body \n $message \n $code';
  }
}

class GetComicsException extends ApiException {
  final Object error;
  GetComicsException(
      {required super.message,
      required super.code,
      super.body,
      required this.error});
}

class GetComicDetailException extends ApiException {
  final Object error;
  GetComicDetailException(
      {required super.message,
      required super.code,
      super.body,
      required this.error});
}