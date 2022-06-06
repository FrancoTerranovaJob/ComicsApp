import 'package:comics_app/app/common/exception/api_exception.dart';
import 'package:comics_app/app/common/exception/domain_exception.dart';
import 'package:comics_app/app/data/comics_data/providers/api/i_comics_api_provider.dart';
import 'package:comics_app/app/data/comics_data/providers/api/model/comics_api_exceptions.dart';
import 'package:comics_app/app/data/comics_data/providers/api/model/request/get_comic_detail_request.dart';
import 'package:comics_app/app/data/comics_data/providers/api/model/request/get_comics_request.dart';
import 'package:comics_app/app/data/comics_data/providers/api/model/response/get_comics_response.dart';
import 'package:comics_app/app/domain/comics_domain/entities/comic.dart';
import 'package:comics_app/app/domain/comics_domain/entities/comic_detail.dart';
import 'package:comics_app/app/domain/comics_domain/entities/comic_list.dart';
import 'package:comics_app/app/domain/comics_domain/repository/i_comics_repository.dart';
import 'package:comics_app/app/domain/comics_domain/repository/model/comics_repository_exceptions.dart';
import 'package:comics_app/di/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@LazySingleton(as: IComicsRepository)
class ComicsRepository implements IComicsRepository {
  final apiProvider = getIt.get<IComicsApiProvider>();
  final dateFormatter = DateFormat('yyyy-MM-dd');
  @override
  Future<ComicList> getComics() async {
    try {
      final comicsResponse = await apiProvider.getComics(GetComicsRequest(
          maxPageLength: 10,
          filters: RequestFilters(
              dateRange: _getFormattedDateFilter(),
              requiredFields: _getRequiredFieldsFilter()),
          offset: 0));
      return ComicList(
        comics: _parseComicResponseToComic(comicsResponse.comics),
        offset: 0,
        remainingComicsCount: comicsResponse.remainingComicsCount,
        pagesCount: comicsResponse.pagesCount,
      );
    } on ApiException catch (error) {
      throw _handleApiExceptions(error);
    } catch (error) {
      throw ComicsRepositoryGetComicsException(message: error, code: '');
    }
  }

  /*
   if offset + number_of_page_results >= number_of_total_results => there is not more results, so return the same ComicList instance
   */
  @override
  Future<ComicList> loadMoreComics(ComicList comicList) async {
    final newOffset = comicList.offset + comicList.pagesCount;
    if (newOffset >= comicList.remainingComicsCount) {
      return comicList;
    } else {
      try {
        final newComicListResponse = await apiProvider.getComics(
            GetComicsRequest(
                maxPageLength: 10,
                offset: newOffset,
                filters: RequestFilters(
                    dateRange: _getFormattedDateFilter(),
                    requiredFields: _getRequiredFieldsFilter())));
        return ComicList(
            comics: _parseComicResponseToComic(newComicListResponse.comics),
            offset: newOffset,
            remainingComicsCount: comicList.remainingComicsCount,
            pagesCount: newComicListResponse.pagesCount);
      } on ApiException catch (error) {
        throw _handleApiExceptions(error);
      } catch (error) {
        throw ComicsRepositoryLoadMoreComicsException(message: error, code: '');
      }
    }
  }

  @override
  Future<ComicDetail> getComicDetail(Comic comic) async {
    try {
      final response = await apiProvider.getComicDetail(GetComicDetailRequest(
          detailUrl: comic.comicDetailUrl,
          requiredFields: _getComicDetailRequiredFieldsFilter()));
      return ComicDetail(
        originalImageUrl: response.imageUrl,
        characterCredits: response.characterCredits
            .map((char) => Character(
                char.apiDetailUrl, char.id, char.name, char.siteDetailUrl))
            .toList(),
        teamCredits: response.characterCredits
            .map((team) =>
                Team(team.apiDetailUrl, team.id, team.name, team.siteDetailUrl))
            .toList(),
        locationCredits: response.characterCredits
            .map((loc) => LocationCredits(
                loc.apiDetailUrl, loc.id, loc.name, loc.siteDetailUrl))
            .toList(),
      );
    } on ApiException catch (error) {
      throw _handleApiExceptions(error);
    } catch (error) {
      throw ComicsRepositoryLoadMoreComicsException(message: error, code: '');
    }
  }

  List<Comic> _parseComicResponseToComic(List<ComicResponse> comicResponse) {
    return comicResponse
        .map((comic) => Comic(
            originalImageUrl: comic.imageUrl,
            dateAdded: comic.dateAdded,
            name: comic.name,
            comicNumber: comic.comicNumber,
            comicDetailUrl: comic.detailUrl))
        .toList();
  }

  /*
    Set what latest comics mean in the below function. Defaults to init of the current year
   */
  String _getFormattedDateFilter() {
    final startOfCurrentYear = DateTime(DateTime.now().year, 1, 1);
    final currentDate = DateTime.now();

    final formattedStartOfYearDate = dateFormatter.format(startOfCurrentYear);
    final formattedCurrentDate = dateFormatter.format(currentDate);
    return '$formattedStartOfYearDate|$formattedCurrentDate';
  }

  /*
    filtering fields for improve request performance
   */
  String _getRequiredFieldsFilter() {
    return 'id,image,date_added,name,api_detail_url,issue_number';
  }

  String _getComicDetailRequiredFieldsFilter() {
    return 'image,character_credits,team_credits,location_credits';
  }

  DomainException _handleApiExceptions(ApiException apiException) {
    if (apiException is DioException) {
      return HttpApiException(
          message: apiException.body,
          code: 'HTTP-EXCEPTION ${apiException.code}');
    } else if (apiException is GetComicsException) {
      return ComicsApiProviderException(
          message: apiException.body,
          code: 'API-EXCEPTION ${apiException.code}');
    } else {
      return ComicsApiProviderException(
          message: apiException.body,
          code: 'API-EXCEPTION ${apiException.code}');
    }
  }
}