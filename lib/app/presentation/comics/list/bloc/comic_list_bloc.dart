import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'comic_list_event.dart';
part 'comic_list_state.dart';

class ComicListBloc extends Bloc<ComicListEvent, ComicListState> {
  ComicListBloc() : super(ComicListInitial()) {
    on<ComicListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}