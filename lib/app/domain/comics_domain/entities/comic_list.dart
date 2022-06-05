import 'package:equatable/equatable.dart';

import 'comic.dart';

class ComicList extends Equatable {
  final List<Comic> comics;
  final int offset;
  final int remainingComicsCount;
  final int pagesCount;

  const ComicList(
      {required this.comics,
      required this.offset,
      required this.remainingComicsCount,
      required this.pagesCount});

  @override
  List<Object> get props => [
        comics,
        offset,
        remainingComicsCount,
        pagesCount,
      ];
}