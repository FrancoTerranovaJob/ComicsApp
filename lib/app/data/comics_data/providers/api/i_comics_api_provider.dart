import 'package:comics_app/app/data/comics_data/providers/api/model/request/get_comic_detail_request.dart';
import 'package:comics_app/app/data/comics_data/providers/api/model/request/get_comics_request.dart';

import 'model/response/get_comic_detail_response.dart';
import 'model/response/get_comics_response.dart';

abstract class IComicsApiProvider {
  Future<GetComicsResponse> getComics(GetComicsRequest getIssuesRequest);
  Future<GetComicDetailResponse> getComicDetail(
      GetComicDetailRequest getComicDetailRequest);
}