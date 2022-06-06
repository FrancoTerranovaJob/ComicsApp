import 'package:comics_app/app/presentation/comics/list/bloc/comic_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/comics_domain/entities/comic.dart';
import '../../../../domain/comics_domain/entities/comic_list.dart';
import '../../../../domain/comics_domain/entities/enum_layout_type.dart';
import '../../../common/sizes/app_sizes.dart';

class ComicsListMode extends StatelessWidget {
  final ComicList comicList;
  final Function(Comic) onComicSelected;
  final ScrollController scrollController;
  final Key listKey;
  final LayoutType layoutType;

  ComicsListMode(
      {Key? key,
      required this.comicList,
      required this.listKey,
      required this.layoutType,
      required this.onComicSelected,
      required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comicListBloc = BlocProvider.of<ComicListBloc>(context);

    return Expanded(
      child: NotificationListener(
          onNotification: (t) {
            if (t is ScrollEndNotification) {
              if ((scrollController.position.pixels ==
                      scrollController.position.maxScrollExtent &&
                  (comicListBloc.state is! ComicListLoadingState))) {
                comicListBloc.add(SearchComicsEvent());
              }
            }
            return true;
          },
          child: _getComicListLayout(context)),
    );
  }

  double _getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  Widget _getComicListLayout(BuildContext context) {
    if (layoutType == LayoutType.list) {
      return _getComicList(1);
    } else {
      final screenSize = _getScreenSize(context);
      if (screenSize >= AppSizes.gridLayoutSmall &&
          screenSize <= AppSizes.gridLayoutMedium) {
        return _getComicList(2);
      } else if (screenSize >= AppSizes.gridLayoutMedium &&
          screenSize <= AppSizes.gridLayoutLarge) {
        return _getComicList(2);
      } else if (screenSize >= AppSizes.gridLayoutLarge) {
        return _getComicList(3);
      } else {
        return _getComicList(3);
      }
    }
  }

  Widget _getComicList(int columnCount) {
    return Scrollbar(
      controller: scrollController,
      child: GridView.builder(
        key: listKey,
        controller: scrollController,
        itemCount: comicList.comics.length,
        itemBuilder: (BuildContext context, int index) {
          if ((index + 1) == comicList.comics.length) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 50,
                      height: 100,
                      child: Container(
                          color: Colors.purpleAccent,
                          child: Text(comicList.comics[index].name))),
                ),
                BlocBuilder<ComicListBloc, ComicListState>(
                    builder: (context, state) {
                  return Visibility(
                      visible: state is ComicListLoadingMoreComicsState,
                      child: Container(
                          width: double.infinity,
                          height: 100,
                          color: Colors.brown));
                })
              ],
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: 50,
                  height: 100,
                  child: Container(
                      color: Colors.purpleAccent,
                      child: Text(comicList.comics[index].name))),
            );
          }
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10.0, crossAxisCount: columnCount),
      ),
    );
  }
}