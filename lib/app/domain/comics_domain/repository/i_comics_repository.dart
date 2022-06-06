import 'package:comics_app/app/domain/comics_domain/entities/comic_detail.dart';

import '../entities/comic.dart';
import '../entities/comic_list.dart';

abstract class IComicsRepository {
  Future<ComicList> getComics();
  Future<ComicList> loadMoreComics(ComicList comicList);
  Future<ComicDetail> getComicDetail(Comic comic);
}