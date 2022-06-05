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
  static const key = String.fromEnvironment('API_KEY');

  final Dio http = getIt<Dio>();

  @override
  Future<GetComicsResponse> getComics(GetComicsRequest getComicsRequest) async {
    try {
      final queryParams = _setGetComicsQueryParams(getComicsRequest);
      final response = await http.get('/issues', queryParameters: queryParams);

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
      final response = await http.get(getComicDetailRequest.detailUrl,
          queryParameters: _getBaseQueryParams(
              limit: 1, format: getComicDetailRequest.responseFormat));

      return GetComicDetailResponse.fromJson(response.data);
    } on DioError catch (error) {
      throw _handleDioError(error);
    } catch (error, track) {
      throw GetComicDetailException(
          message: error.toString(), code: '', body: track, error: error);
    }
  }

  Map<String, dynamic> _setGetComicsQueryParams(
      GetComicsRequest getComicsRequest) {
    final queryParams = _getBaseQueryParams(
        limit: getComicsRequest.maxPageLength,
        format: getComicsRequest.responseFormat);
    queryParams['offset'] = getComicsRequest.offset;
    final stFilters = _parseFiltersToString(getComicsRequest.filters);
    if (stFilters.isNotEmpty) {
      queryParams['filter'] = stFilters;
    }
    queryParams['sort'] = getComicsRequest.filters.order == OrderType.orderDESC
        ? 'date_added:desc'
        : 'date_added:asc';
    return queryParams;
  }

  Map<String, dynamic> _getBaseQueryParams(
      {required int limit, required String format}) {
    return {'api_key': key, 'format': format, 'limit': limit};
  }

  String _parseFiltersToString(RequestFilters filters) {
    var filterString = '';

    if (filters.dateRange.isNotEmpty && filters.dateRange.contains('|')) {
      filterString = 'date_added:${filters.dateRange}';
    }
    return filterString;
  }

  DioException _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.response:
        return DioException(
            message: "Comics api response exception: ${error.toString()}",
            body: error.requestOptions.path,
            code: 'Code error: ${error.response?.statusCode ?? ''} ');

      case DioErrorType.connectTimeout:
        return DioException(
            message:
                "Comics api connection timeout exception: ${error.toString()}",
            body: error.requestOptions.path,
            code:
                'Code error: ${error.response?.statusCode?.toString() ?? ''}');

      case DioErrorType.sendTimeout:
        return DioException(
            message:
                "Comics api sending timeout exception: ${error.toString()}",
            body: error.requestOptions.path,
            code:
                'Code error: ${error.response?.statusCode?.toString() ?? ''}');

      case DioErrorType.receiveTimeout:
        return DioException(
            message:
                "Comics api receive timeout exception: ${error.toString()}",
            body: error.requestOptions.path,
            code:
                'Code error: ${error.response?.statusCode?.toString() ?? ''}');

      case DioErrorType.cancel:
        return DioException(
            message:
                "Comics api request canceled exception: ${error.toString()}",
            body: error.requestOptions.path,
            code:
                'Code error: ${error.response?.statusCode?.toString() ?? ''}');

      case DioErrorType.other:
        return DioException(
            message: "Comics api unknown exception: ${error.toString()}",
            body: error.requestOptions.path,
            code:
                'Code error: ${error.response?.statusCode?.toString() ?? ''}');
    }
  }
}