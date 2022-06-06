import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class HttpModule {
  @singleton
  Dio get dio => Dio(BaseOptions(baseUrl: dotenv.env['API_URL']!))
    ..interceptors.addAll([PrettyDioLogger()]);
}