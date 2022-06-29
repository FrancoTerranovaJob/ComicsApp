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

@LazySingleton(as: IComicsRepository)
class ComicsRepository implements IComicsRepository {
  final apiProvider = getIt.get<IComicsApiProvider>();

  @override
  Future<ComicList> getComics() async {
    try {
      final comicsResponse = await apiProvider
          .getComics(const GetComicsRequest(maxPageLength: 30, offset: 0));
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
        final newComicListResponse =
            await apiProvider.getComics(GetComicsRequest(
          maxPageLength: 30,
          offset: newOffset,
        ));

        final newComicList = <Comic>[];
        newComicList.addAll(comicList.comics);
        newComicList
            .addAll(_parseComicResponseToComic(newComicListResponse.comics));
        return ComicList(
            comics: newComicList,
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
      ));
      return ComicDetail(
        originalImageUrl: response.imageUrl,
        characterCredits: response.characterCredits
            .map((char) => Character(
                char.apiDetailUrl, char.id, char.name, char.siteDetailUrl))
            .toList(),
        teamCredits: response.teamCredits
            .map((team) =>
                Team(team.apiDetailUrl, team.id, team.name, team.siteDetailUrl))
            .toList(),
        locationCredits: response.locationCredits
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