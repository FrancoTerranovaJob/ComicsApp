import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comics_app/app/domain/comics_domain/entities/enum_layout_type.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/comics_domain/entities/comic_list.dart';

part 'comic_list_event.dart';
part 'comic_list_state.dart';

class ComicListBloc extends Bloc<ComicListEvent, ComicListState> {
  ComicListBloc(ComicListState comicListState) : super(comicListState) {
    on<ComicListEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ChangeLayoutEvent>((event, emit) {
      emit(ComicListDataState(
          layoutType: event.layoutType,
          changeLayoutEnabled: state.changeLayoutEnabled,
          comics: state.comics));
    });
  }
}