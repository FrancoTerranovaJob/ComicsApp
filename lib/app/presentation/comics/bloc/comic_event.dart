part of 'comic_bloc.dart';

abstract class ComicEvent extends Equatable {
  const ComicEvent();
}

class OnComicPressedEvent extends ComicEvent {
  final Comic comic;

  const OnComicPressedEvent({required this.comic});
  @override
  List<Object> get props => [comic];
}