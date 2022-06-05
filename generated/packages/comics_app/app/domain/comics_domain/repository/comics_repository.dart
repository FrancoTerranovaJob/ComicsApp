import 'package:comics_app/app/domain/comics_domain/repository/i_comics_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IComicsRepository)
class ComicsRepository implements IComicsRepository {}