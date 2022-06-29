import 'package:comics_app/app/data/comics_data/providers/api/i_comics_api_provider.dart';
import 'package:comics_app/app/data/comics_data/providers/api/model/comics_api_exceptions.dart';
import 'package:comics_app/app/data/comics_data/providers/api/model/request/get_comic_detail_request.dart';
import 'package:comics_app/app/data/comics_data/providers/api/model/request/get_comics_request.dart';
import 'package:comics_app/app/data/comics_data/providers/api/model/response/get_comic_detail_response.dart';
import 'package:comics_app/app/data/comics_data/providers/api/model/response/get_comics_response.dart';
import 'package:comics_app/di/get_it.dart';
import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';

@Singleton(as: IComicsApiProvider)
class ComicsApiProvider implements IComicsApiProvider {
  final Dio http = getIt.get<Dio>();

  @override
  Future<GetComicsResponse> getComics(GetComicsRequest getComicsRequest) async {
    try {
      final response = await http.post('/issues',
          queryParameters: _getComicsQueryParams(getComicsRequest));

      return GetComicsResponse.fromJson(response.data);
    } on DioError catch (error) {
      throw _handleDioError(error);
    } catch (error, track) {
      throw GetComicsException(
          code: '', message: error.toString(), body: track, error: error);
    }
  }

  @override
  Future<GetComicDetailResponse> getComicDetail(
      GetComicDetailRequest getComicDetailRequest) async {
    try {
      final response = await http.post('/issue_detail',
          queryParameters: {'detail_url': getComicDetailRequest.detailUrl});

      return GetComicDetailResponse.fromJson(response.data);
    } on DioError catch (error) {
      throw _handleDioError(error);
    } catch (error, track) {
      throw GetComicDetailException(
          message: error.toString(), code: '', body: track, error: error);
    }
  }

  Map<String, dynamic> _getComicsQueryParams(
      GetComicsRequest getComicsRequest) {
    final queryParams = <String, dynamic>{};
    queryParams['limit'] = getComicsRequest.maxPageLength;
    queryParams['offset'] = getComicsRequest.offset;
    return queryParams;
  }

  DioException _handleDioError(DioError error) {
    final pathRequested = 'PATH REQUESTED: ${error.requestOptions.path}';
    switch (error.type) {
      case DioErrorType.response:
        return DioException(
            message: "Comics api response exception: ${error.toString()}",
            body: pathRequested,
            code: 'Code error: ${error.response?.statusCode ?? ''} ');

      case DioErrorType.connectTimeout:
        return DioException(
            message:
                "Comics api connection timeout exception: ${error.toString()}",
            body: pathRequested,
            code:
                'Code error: ${error.response?.statusCode?.toString() ?? ''}');

      case DioErrorType.sendTimeout:
        return DioException(
            message:
                "Comics api sending timeout exception: ${error.toString()}",
            body: pathRequested,
            code:
                'Code error: ${error.response?.statusCode?.toString() ?? ''}');

      case DioErrorType.receiveTimeout:
        return DioException(
            message:
                "Comics api receive timeout exception: ${error.toString()}",
            body: pathRequested,
            code:
                'Code error: ${error.response?.statusCode?.toString() ?? ''}');

      case DioErrorType.cancel:
        return DioException(
            message:
                "Comics api request canceled exception: ${error.toString()}",
            body: pathRequested,
            code:
                'Code error: ${error.response?.statusCode?.toString() ?? ''}');

      case DioErrorType.other:
        return DioException(
            message: "Comics api unknown exception: ${error.toString()}",
            body: pathRequested,
            code:
                'Code error: ${error.response?.statusCode?.toString() ?? ''}');
    }
  }
}