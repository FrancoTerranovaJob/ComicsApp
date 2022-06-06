import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'comic_event.dart';
part 'comic_state.dart';

class ComicBloc extends Bloc<ComicEvent, ComicState> {
  ComicBloc() : super(ComicInitial()) {
    on<ComicEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}