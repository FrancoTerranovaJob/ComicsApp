part of 'comic_detail_bloc.dart';

abstract class ComicDetailState extends Equatable {
  final ComicDetail comicDetail;
  final Comic comic;
  const ComicDetailState({required this.comicDetail, required this.comic});
  @override
  List<Object> get props => [comicDetail, comic];
}

class ComicDetailInitial extends ComicDetailState {
  ComicDetailInitial({required super.comicDetail, required super.comic});
}

class ComicDetailDataState extends ComicDetailState {
  ComicDetailDataState({required super.comicDetail, required super.comic});
}

class ComicDetailLoadingState extends ComicDetailState {
  ComicDetailLoadingState({required super.comicDetail, required super.comic});
}

class ComicDetailErrorState extends ComicDetailState {
  ComicDetailErrorState({required super.comicDetail, required super.comic});
}