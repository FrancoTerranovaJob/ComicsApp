import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comics_app/app/domain/comics_domain/comics_use_cases/get_comics_use_case.dart';
import 'package:comics_app/app/domain/comics_domain/comics_use_cases/load_more_comics_use_case.dart';
import 'package:comics_app/app/domain/comics_domain/entities/enum_layout_type.dart';
import 'package:comics_app/di/get_it.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/comics_domain/entities/comic_list.dart';

part 'comic_list_event.dart';
part 'comic_list_state.dart';

class ComicListBloc extends Bloc<ComicListEvent, ComicListState> {
  final getComicsUseCase = getIt.get<GetComicsUseCase>();
  final getMoreComicsUseCase = getIt.get<LoadMoreComicsUseCase>();
  ComicListBloc(ComicListState comicListState) : super(comicListState) {
    on<ComicListEvent>((event, emit) {});

    on<ChangeLayoutEvent>((event, emit) {
      emit(ComicListDataState(
          layoutType: event.layoutType,
          changeLayoutEnabled: state.changeLayoutEnabled,
          comics: state.comics));
    });

    on<SearchComicsEvent>((event, emit) async {
      if (state is ComicListInitial) {
        try {
          emit(ComicListLoadingState(
              changeLayoutEnabled: state.changeLayoutEnabled,
              comics: state.comics,
              layoutType: state.layoutType));
          final response = await getComicsUseCase.call();
          emit(ComicListDataState(
              layoutType: state.layoutType,
              changeLayoutEnabled: state.changeLayoutEnabled,
              comics: response));
        } catch (e) {
          emit(ComicListErrorState(
              layoutType: state.layoutType,
              changeLayoutEnabled: state.changeLayoutEnabled,
              comics: state.comics));
        }
      } else if (state is ComicListDataState) {
        try {
          emit(ComicListLoadingMoreComicsState(
              changeLayoutEnabled: state.changeLayoutEnabled,
              comics: state.comics,
              layoutType: state.layoutType));
          final response = await getMoreComicsUseCase.call(state.comics);
          if (response != state.comics) {
            emit(ComicListDataState(
                layoutType: state.layoutType,
                changeLayoutEnabled: state.changeLayoutEnabled,
                comics: response));
          }
        } catch (e) {
          emit(ComicListErrorState(
              layoutType: state.layoutType,
              changeLayoutEnabled: state.changeLayoutEnabled,
              comics: state.comics));
        }
      }
    });

    on<ComicListDisableChangeLayoutEvent>((event, emit) {
      emit(ComicListDataState(
          layoutType: state.layoutType,
          changeLayoutEnabled: false,
          comics: state.comics));
    });

    on<ComicListEnableChangeLayoutEvent>((event, emit) {
      emit(ComicListDataState(
          layoutType: state.layoutType,
          changeLayoutEnabled: true,
          comics: state.comics));
    });
  }
}