part of 'comic_detail_bloc.dart';

abstract class ComicDetailEvent extends Equatable {
  const ComicDetailEvent();
}

class SearchComicDetailEvent extends ComicDetailEvent {
  @override
  List<Object> get props => [];
}