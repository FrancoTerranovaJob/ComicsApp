import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class HttpModule {
  @singleton
  Dio get dio => Dio(BaseOptions(baseUrl: 'http://127.0.0.1:8081'))
    ..interceptors
        .addAll([PrettyDioLogger(requestHeader: true, responseHeader: true)]);
}