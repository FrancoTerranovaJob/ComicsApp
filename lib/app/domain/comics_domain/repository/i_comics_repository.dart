import '../entities/comic_list.dart';

abstract class IComicsRepository {
  Future<ComicList> getComics();
  Future<ComicList> loadMoreComics(ComicList comicList);
}