import 'package:auto_size_text/auto_size_text.dart';
import 'package:comics_app/app/presentation/comics/list/bloc/comic_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/comics_domain/entities/comic.dart';
import '../../../../domain/comics_domain/entities/comic_list.dart';
import '../../../common/sizes/app_sizes.dart';

class ComicsGridLayout extends StatelessWidget {
  final ScrollController scrollController;
  final ComicList comicList;
  final Function(Comic comic) onComicSelected;
  const ComicsGridLayout(
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
      child: GridView.builder(
        itemCount: comicList.comics.length,
        controller: scrollController,
        itemBuilder: (BuildContext bContext, int index) {
          return Material(
            child: InkWell(
              onTap: () {
                onComicSelected(comicList.comics[index]);
              },
              child: SizedBox(
                width: 300,
                height: 500,
                child: Column(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Image.network(
                            comicList.comics[index].originalImageUrl)),
                    Expanded(child: Text(comicList.comics[index].name)),
                    Expanded(
                      child: AutoSizeText(
                        comicList.comics[index].name.isNotEmpty
                            ? '${comicList.comics[index].name} #${comicList.comics[index].comicNumber}'
                            : 'Unknown Name #${comicList.comics[index].comicNumber}',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: Text(
                          comicList.comics[index].dateAdded,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _getAxisCount(context),
          childAspectRatio: 1,
        ),
      ),
    );
  }

  int _getAxisCount(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    if (screenSize < AppSizes.minScreenWidthLimit) {
      return 1;
    } else if (screenSize >= AppSizes.minScreenWidthLimit &&
        screenSize < AppSizes.minScreenWidthLimitMedium) {
      return 2;
    } else {
      return 4;
    }
  }
}