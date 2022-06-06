import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comics_app/app/domain/comics_domain/entities/enum_layout_type.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/comics_domain/entities/comic.dart';

part 'comic_event.dart';
part 'comic_state.dart';

class ComicBloc extends Bloc<ComicEvent, ComicState> {
  ComicBloc(ComicState comicState) : super(comicState) {
    on<OnComicPressedEvent>((event, emit) {
      emit(ShowComicDetailState(comic: event.comic));
    });
  }
}