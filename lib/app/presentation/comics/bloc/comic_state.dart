part of 'comic_bloc.dart';

abstract class ComicState extends Equatable {
  final Comic? comic;

  const ComicState({this.comic});
  @override
  List<Object> get props => [];
}

class ComicInitial extends ComicState {}

class ComicPageState extends ComicState {}

class ShowComicListState extends ComicState {}

class ShowComicDetailState extends ComicState {
  const ShowComicDetailState({super.comic});
}