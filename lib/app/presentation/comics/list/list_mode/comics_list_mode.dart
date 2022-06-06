import 'package:flutter/material.dart';

import '../../../../domain/comics_domain/entities/comic.dart';
import '../../../../domain/comics_domain/entities/comic_list.dart';

class ComicsListMode extends StatelessWidget {
  final ComicList comicList;
  final Function(Comic) onComicSelected;
  const ComicsListMode(
      {Key? key, required this.comicList, required this.onComicSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
    );
  }
}