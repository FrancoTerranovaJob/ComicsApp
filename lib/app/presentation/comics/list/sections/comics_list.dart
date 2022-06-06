import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/comics_domain/entities/comic.dart';
import '../../../../domain/comics_domain/entities/comic_list.dart';
import '../../../common/sizes/app_sizes.dart';
import '../bloc/comic_list_bloc.dart';

class ComicsListLayout extends StatelessWidget {
  final ScrollController scrollController;
  final ComicList comicList;
  final Function(Comic comic) onComicSelected;
  const ComicsListLayout(
      {Key? key,
      required this.comicList,
      required this.scrollController,
      required this.onComicSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comicBloc = BlocProvider.of<ComicListBloc>(context);
    return NotificationListener(
      onNotification: (t) {
        if (t is ScrollEndNotification) {
          if ((scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent &&
              (comicBloc.state is! ComicListLoadingMoreComicsState))) {
            comicBloc.add(SearchComicsEvent());
          }
        }
        return true;
      },
      child: ListView.builder(
        controller: scrollController,
        itemCount: comicList.comics.length,
        itemBuilder: (BuildContext bContext, int index) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              bool isSmall = _getAxisCount(context);
              if (isSmall) {
                return SmallListPortrait(
                    comic: comicList.comics[index],
                    onClick: (comic) {
                      onComicSelected(comic);
                    });
              }
              return LargeListPortrait(
                  comic: comicList.comics[index],
                  onClick: (comic) {
                    onComicSelected(comic);
                  });
            },
          );
        },
      ),
    );
  }

  bool _getAxisCount(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    if (screenSize < AppSizes.minScreenWidthLimit) {
      return true;
    }
    return false;
  }
}

class SmallListPortrait extends StatelessWidget {
  final Function(Comic comic) onClick;
  final Comic comic;
  const SmallListPortrait(
      {Key? key, required this.comic, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          onClick(comic);
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 200,
                height: 300,
                child: Image.network(comic.originalImageUrl),
              ),
            ),
            AutoSizeText(
              comic.name.isNotEmpty
                  ? '${comic.name} #${comic.comicNumber}'
                  : 'Unknown Name',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: double.infinity,
              height: 100,
              child: Text(
                comic.dateAdded,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LargeListPortrait extends StatelessWidget {
  final Function(Comic comic) onClick;
  final Comic comic;
  const LargeListPortrait(
      {Key? key, required this.comic, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          onClick(comic);
        },
        child: Row(
          children: [
            Expanded(child: Container()),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(comic.originalImageUrl),
            )),
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    AutoSizeText(
                      comic.name.isNotEmpty
                          ? '${comic.name} #${comic.comicNumber}'
                          : 'Unknown Name #${comic.comicNumber}',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Text(
                        comic.dateAdded,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}