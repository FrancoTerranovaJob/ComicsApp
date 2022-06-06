import 'package:comics_app/app/domain/comics_domain/entities/comic_list.dart';
import 'package:comics_app/app/domain/comics_domain/entities/enum_layout_type.dart';
import 'package:comics_app/app/presentation/comics/bloc/comic_bloc.dart';
import 'package:comics_app/app/presentation/comics/list/bloc/comic_list_bloc.dart';
import 'package:comics_app/app/presentation/comics/list/sections/comics_grid_layout.dart';
import 'package:comics_app/app/presentation/comics/list/sections/comics_list.dart';
import 'package:comics_app/app/presentation/common/sizes/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComicListScreen extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  ComicListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comicBloc = BlocProvider.of<ComicListBloc>(context);
    return BlocConsumer<ComicListBloc, ComicListState>(
      buildWhen: (p, c) => c is! ComicListLoadingMoreComicsState,
      listener: (context, state) {},
      builder: (context, state) {
        return Column(children: [
          const Expanded(child: ComicListHeader()),
          const Divider(),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              _handleLayoutChanges(constraints, context, comicBloc);
              return Container(
                width: 0,
                height: 0,
              );
            },
          ),
          Expanded(
              flex: 7,
              child: _buildLayout(state.layoutType, state.comics, context))
        ]);
      },
    );
  }

  Widget _buildLayout(
      LayoutType layoutType, ComicList comicList, BuildContext context) {
    if (layoutType == LayoutType.list) {
      return ComicsListLayout(
        comicList: comicList,
        scrollController: scrollController,
        onComicSelected: (comic) {
          _addComicBlocEvent(OnComicPressedEvent(comic: comic), context);
        },
      );
    } else {
      return ComicsGridLayout(
        comicList: comicList,
        scrollController: scrollController,
        onComicSelected: (comic) {
          _addComicBlocEvent(OnComicPressedEvent(comic: comic), context);
        },
      );
    }
  }

  void _addComicBlocEvent(ComicEvent event, BuildContext context) {
    final comicsPageBloc = BlocProvider.of<ComicBloc>(context);
    comicsPageBloc.add(event);
  }

  void _handleLayoutChanges(
      BoxConstraints constraints, BuildContext context, ComicListBloc bloc) {
    if (constraints.maxWidth < AppSizes.minScreenWidthLimit) {
      bloc.add(ComicListDisableChangeLayoutEvent());
    } else {
      if (!bloc.state.changeLayoutEnabled) {
        bloc.add(ComicListEnableChangeLayoutEvent());
      }
    }
  }
}

class ComicListHeader extends StatelessWidget {
  const ComicListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 300,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Latest Issues',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
        BlocBuilder<ComicListBloc, ComicListState>(
          builder: (context, state) {
            return Visibility(
              visible: state.changeLayoutEnabled,
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        _addComicListBlocEvent(
                            ChangeLayoutEvent(layoutType: LayoutType.list),
                            context);
                      },
                      child: Row(
                        children: [
                          Text(
                            "List",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.black),
                          ),
                          const Icon(
                            Icons.list,
                            color: Colors.black,
                          ),
                        ],
                      )),
                  TextButton(
                      onPressed: () {
                        _addComicListBlocEvent(
                            ChangeLayoutEvent(layoutType: LayoutType.grid),
                            context);
                      },
                      child: Row(
                        children: [
                          Text(
                            "Grid",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.black),
                          ),
                          const Icon(
                            Icons.grid_view,
                            color: Colors.black,
                          )
                        ],
                      ))
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void _addComicListBlocEvent(ComicListEvent event, BuildContext context) {
    final comicsListBloc = BlocProvider.of<ComicListBloc>(context);
    comicsListBloc.add(event);
  }
}