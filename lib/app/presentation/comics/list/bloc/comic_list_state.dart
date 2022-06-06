part of 'comic_list_bloc.dart';

abstract class ComicListState extends Equatable {
  const ComicListState();
}

class ComicListInitial extends ComicListState {
  @override
  List<Object> get props => [];
}