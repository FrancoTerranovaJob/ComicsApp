import 'dart:developer';

import 'package:comics_app/app/common/exception/api_exception.dart';
import 'package:comics_app/app/data/comics_data/providers/api/i_comics_api_provider.dart';
import 'package:comics_app/app/data/comics_data/providers/api/model/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../di/get_it.dart';

@Singleton(as: IComicsApiProvider)
class ComicsApiProvider implements IComicsApiProvider {
  final api = getIt.get<Dio>();
  ComicsApiProvider() {
    api.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {
        log(_handleDioError(error).toString());
        handler.next(error);
      },
    ));
  }

  DioException _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.response:
        return DioException(
            message: "Comics api response exception:\n ${error.toString()}",
            body: error.requestOptions.path,
            code:
                'Code error: ${error.response?.statusCode?.toString() ?? ''}');

      case DioErrorType.connectTimeout:
        return DioException(
            message:
                "Comics api connection timeout exception:\n ${error.toString()}",
            body: error.requestOptions.path,
            code:
                'Code error: ${error.response?.statusCode?.toString() ?? ''}');

      case DioErrorType.sendTimeout:
        return DioException(
            message:
                "Comics api sending timeout exception:\n ${error.toString()}",
            body: error.requestOptions.path,
            code:
                'Code error: ${error.response?.statusCode?.toString() ?? ''}');

      case DioErrorType.receiveTimeout:
        return DioException(
            message:
                "Comics api receive timeout exception:\n ${error.toString()}",
            body: error.requestOptions.path,
            code:
                'Code error: ${error.response?.statusCode?.toString() ?? ''}');

      case DioErrorType.cancel:
        return DioException(
            message:
                "Comics api request canceled exception:\n ${error.toString()}",
            body: error.requestOptions.path,
            code:
                'Code error: ${error.response?.statusCode?.toString() ?? ''}');

      case DioErrorType.other:
        return DioException(
            message: "Comics api unknown exception:\n ${error.toString()}",
            body: error.requestOptions.path,
            code:
                'Code error: ${error.response?.statusCode?.toString() ?? ''}');
    }
  }
}