import 'package:comics_app/app/domain/comics_domain/entities/comic_list.dart';
import 'package:comics_app/app/domain/comics_domain/repository/i_comics_repository.dart';

import 'package:comics_app/di/get_it.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetComicsUseCase {
  final repository = getIt.get<IComicsRepository>();

  Future<ComicList> call() async {
    try {
      return await repository.getComics();
    } catch (e) {
      rethrow;
    }
  }
}