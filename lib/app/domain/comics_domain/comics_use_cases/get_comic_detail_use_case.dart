import 'package:comics_app/app/domain/comics_domain/entities/comic.dart';
import 'package:comics_app/app/domain/comics_domain/entities/comic_detail.dart';
import 'package:injectable/injectable.dart';
import '../../../../di/get_it.dart';
import '../repository/i_comics_repository.dart';

@lazySingleton
class GetComicDetailUseCase {
  final repository = getIt.get<IComicsRepository>();

  Future<ComicDetail> call(Comic param) async {
    try {
      return await repository.getComicDetail(param);
    } catch (e) {
      rethrow;
    }
  }
}