import 'package:comics_app/app/domain/comics_domain/entities/comic_list.dart';
import 'package:comics_app/app/presentation/common/sizes/app_sizes.dart';
import 'package:flutter/material.dart';

import '../../../../domain/comics_domain/entities/comic.dart';

class ComicsGridMode extends StatelessWidget {
  final ComicList comicList;
  final Function(Comic) onComicSelected;

  const ComicsGridMode(
      {Key? key, required this.comicList, required this.onComicSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = _getScreenSize(context);
    final gridType = _getGridType(screenSize);

    return gridType;
  }

  double _getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  Widget _getGridType(double screenSize) {
    if (screenSize >= AppSizes.gridLayoutSmall &&
        screenSize <= AppSizes.gridLayoutMedium) {
      return Container(
        width: double.infinity,
        color: Colors.yellow,
        child: Text('Grid layout small'),
      );
    } else if (screenSize >= AppSizes.gridLayoutMedium &&
        screenSize <= AppSizes.gridLayoutLarge) {
      return Container(
        width: double.infinity,
        color: Colors.amber,
        child: Text('Grid layout medium'),
      );
    } else if (screenSize >= AppSizes.gridLayoutLarge) {
      return Container(
        width: double.infinity,
        color: Colors.green,
        child: Text('Grid layout large'),
      );
    } else {
      return Container(
        width: double.infinity,
        color: Colors.yellow,
      );
    }
  }
}

class ComicsSmallGridList extends StatelessWidget {
  const ComicsSmallGridList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ComicsMediumGridList extends StatelessWidget {
  const ComicsMediumGridList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ComicsLargeGridList extends StatelessWidget {
  const ComicsLargeGridList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}