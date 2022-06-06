part of 'comic_bloc.dart';

abstract class ComicState extends Equatable {
  const ComicState();
}

class ComicInitial extends ComicState {
  @override
  List<Object> get props => [];
}