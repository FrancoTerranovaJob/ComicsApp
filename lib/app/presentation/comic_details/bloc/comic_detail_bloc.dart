import 'package:bloc/bloc.dart';
import 'package:comics_app/app/domain/comics_domain/comics_use_cases/get_comic_detail_use_case.dart';
import 'package:comics_app/di/get_it.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/comics_domain/entities/comic.dart';
import '../../../domain/comics_domain/entities/comic_detail.dart';

part 'comic_detail_event.dart';
part 'comic_detail_state.dart';

class ComicDetailBloc extends Bloc<ComicDetailEvent, ComicDetailState> {
  final getDetailUseCase = getIt.get<GetComicDetailUseCase>();
  ComicDetailBloc(ComicDetailState comicDetailState) : super(comicDetailState) {
    on<SearchComicDetailEvent>((event, emit) async {
      emit(ComicDetailLoadingState(
          comicDetail: state.comicDetail, comic: state.comic));
      try {
        final response = await getDetailUseCase.call(state.comic);
        emit(ComicDetailDataState(comicDetail: response, comic: state.comic));
      } catch (e) {
        emit(ComicDetailErrorState(
            comicDetail: state.comicDetail, comic: state.comic));
      }
    });
  }
}