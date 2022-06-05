// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../app/data/comics_data/providers/api/comics_api_provider.dart' as _i5;
import '../app/data/comics_data/providers/api/i_comics_api_provider.dart'
    as _i4;
import '../app/domain/comics_domain/repository/comics_repository.dart' as _i7;
import '../app/domain/comics_domain/repository/i_comics_repository.dart' as _i6;
import 'api_module/api_module.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final apiModule = _$ApiModule();
  gh.factory<_i3.Dio>(() => apiModule.dio);
  gh.singleton<_i4.IComicsApiProvider>(_i5.ComicsApiProvider());
  gh.singleton<_i6.IComicsRepository>(_i7.ComicsRepository());
  return get;
}

class _$ApiModule extends _i8.ApiModule {}
