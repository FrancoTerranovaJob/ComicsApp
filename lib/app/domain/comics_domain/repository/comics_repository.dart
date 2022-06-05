import 'package:comics_app/app/common/exception/api_exception.dart';
import 'package:comics_app/app/common/exception/domain_exception.dart';
import 'package:comics_app/app/data/comics_data/providers/api/i_comics_api_provider.dart';
import 'package:comics_app/app/data/comics_data/providers/api/model/comics_api_exceptions.dart';
import 'package:comics_app/app/data/comics_data/providers/api/model/request/get_comics_request.dart';
import 'package:comics_app/app/domain/comics_domain/entities/comic.dart';
import 'package:comics_app/app/domain/comics_domain/entities/comic_list.dart';
import 'package:comics_app/app/domain/comics_domain/repository/i_comics_repository.dart';
import 'package:comics_app/app/domain/comics_domain/repository/model/comics_repository_exceptions.dart';
import 'package:comics_app/di/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@Singleton(as: IComicsRepository)
class ComicsRepository implements IComicsRepository {
  final apiProvider = getIt<IComicsApiProvider>();
  final dateFormatter = DateFormat('yyyy-MM-dd');
  @override
  Future<ComicList> getComics() async {
    try {
      final comicsResponse = await apiProvider.getComics(GetComicsRequest(
          maxPageLength: 10, filters: _getFormattedDateFilter()));
      final comicsList = comicsResponse.comics
          .map((comic) => Comic(
              originalImageUrl: comic.imageUrl,
              dateAdded: comic.dateAdded,
              name: comic.name,
              comicNumber: comic.comicNumber))
          .toList();
      return ComicList(
        comics: comicsList,
        offset: 0,
        remainingComicsCount: comicsResponse.remainingComicsCount,
        pagesCount: comicsResponse.pagesCount,
      );
    } on ApiException catch (error) {
      throw _handleApiExceptions(error);
    } catch (error) {
      throw ComicsRepositoryException(message: error, code: '');
    }
  }

  @override
  Future<ComicList> loadMoreComics(ComicList comicList) async {
    return ComicList(
        comics: [], offset: 2, remainingComicsCount: 3, pagesCount: 4);
  }

  String _getFormattedDateFilter() {
    final startOfCurrentYear = DateTime(DateTime.now().year, 1, 1);
    final currentDate = DateTime.now();

    final formattedStartOfYearDate = dateFormatter.format(startOfCurrentYear);
    final formattedCurrentDate = dateFormatter.format(currentDate);
    return '$formattedStartOfYearDate|$formattedCurrentDate';
  }

// si offset + number_of_page_results = number_of_total_results => ya se mostraron los ultimos resultados

  DomainException _handleApiExceptions(ApiException apiException) {
    if (apiException is DioException) {
      return HttpApiException(
          message: apiException.body, code: 'HTTP-EXCEPTION');
    } else if (apiException is GetComicsException) {
      return ComicsApiProviderException(
          message: apiException.body, code: 'API-EXCEPTION');
    } else {
      return ComicsApiProviderException(
          message: apiException.body, code: 'API-EXCEPTION');
    }
  }
}