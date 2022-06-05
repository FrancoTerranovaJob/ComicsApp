import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

@module
abstract class ApiModule {
  Dio get dio => Dio(BaseOptions(baseUrl: dotenv.env['API_URL']!));
}