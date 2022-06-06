part of 'comic_list_bloc.dart';

abstract class ComicListState extends Equatable {
  final LayoutType layoutType;
  final bool changeLayoutEnabled;
  final ComicList comics;
  const ComicListState(
      {required this.layoutType,
      required this.changeLayoutEnabled,
      required this.comics});
  @override
  List<Object> get props => [layoutType, changeLayoutEnabled, comics];
}

class ComicListInitial extends ComicListState {
  ComicListInitial(
      {required super.layoutType,
      required super.changeLayoutEnabled,
      required super.comics});
}

class ComicListDataState extends ComicListState {
  ComicListDataState(
      {required super.layoutType,
      required super.changeLayoutEnabled,
      required super.comics});
}

class ComicListErrorState extends ComicListState {
  ComicListErrorState(
      {required super.layoutType,
      required super.changeLayoutEnabled,
      required super.comics});
}

class ComicListLoadingState extends ComicListState {
  ComicListLoadingState(
      {required super.layoutType,
      required super.changeLayoutEnabled,
      required super.comics});
}