// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../app/data/comics_data/providers/api/comics_api_provider.dart' as _i7;
import '../app/data/comics_data/providers/api/i_comics_api_provider.dart'
    as _i6;
import '../app/domain/comics_domain/comics_use_cases/get_comic_detail_use_case.dart'
    as _i4;
import '../app/domain/comics_domain/comics_use_cases/get_comics_use_case.dart'
    as _i5;
import '../app/domain/comics_domain/comics_use_cases/load_more_comics_use_case.dart'
    as _i10;
import '../app/domain/comics_domain/repository/comics_repository.dart' as _i9;
import '../app/domain/comics_domain/repository/i_comics_repository.dart' as _i8;
import 'http_module/http_module.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final httpModule = _$HttpModule();
  gh.singleton<_i3.Dio>(httpModule.dio);
  gh.lazySingleton<_i4.GetComicDetailUseCase>(
      () => _i4.GetComicDetailUseCase());
  gh.lazySingleton<_i5.GetComicsUseCase>(() => _i5.GetComicsUseCase());
  gh.singleton<_i6.IComicsApiProvider>(_i7.ComicsApiProvider());
  gh.lazySingleton<_i8.IComicsRepository>(() => _i9.ComicsRepository());
  gh.lazySingleton<_i10.LoadMoreComicsUseCase>(
      () => _i10.LoadMoreComicsUseCase());
  return get;
}

class _$HttpModule extends _i11.HttpModule {}
