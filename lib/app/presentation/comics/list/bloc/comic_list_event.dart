part of 'comic_list_bloc.dart';

abstract class ComicListEvent extends Equatable {
  const ComicListEvent();
}

class ComicListDisableGridLayoutEvent extends ComicListEvent {
  @override
  List<Object?> get props => [];
}

class ComicListEnableGridLayoutEvent extends ComicListEvent {
  @override
  List<Object?> get props => [];
}

class ChangeLayoutEvent extends ComicListEvent {
  final LayoutType layoutType;

  ChangeLayoutEvent({required this.layoutType});
  @override
  List<Object?> get props => [layoutType];
}