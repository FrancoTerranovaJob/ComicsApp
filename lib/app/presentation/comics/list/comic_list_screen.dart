import 'package:comics_app/app/domain/comics_domain/entities/enum_layout_type.dart';
import 'package:comics_app/app/presentation/comics/bloc/comic_bloc.dart';
import 'package:comics_app/app/presentation/comics/list/bloc/comic_list_bloc.dart';
import 'package:comics_app/app/presentation/comics/list/grid_mode/comics_grid_mode.dart';
import 'package:comics_app/app/presentation/comics/list/list_mode/comics_list_mode.dart';
import 'package:comics_app/app/presentation/common/sizes/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComicListScreen extends StatelessWidget {
  const ComicListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComicListBloc, ComicListState>(
      listener: (context, state) {},
      builder: (context, state) {
        return LayoutBuilder(builder: (lyContext, constraint) {
          if (state.changeLayoutEnabled &&
              constraint.maxWidth < AppSizes.minScreenWidthLimit) {
            _addComicListBlocEvent(ComicListDisableGridLayoutEvent(), context);
          } else if (!state.changeLayoutEnabled &&
              constraint.maxWidth >= AppSizes.minScreenWidthLimit) {
            _addComicListBlocEvent(ComicListEnableGridLayoutEvent(), context);
          }
          if (constraint.maxWidth >= AppSizes.minScreenWidthLimit) {
            if ((state.layoutType != LayoutType.grid)) {
              _addComicListBlocEvent(
                  ChangeLayoutEvent(layoutType: LayoutType.grid), context);
            }
          } else {
            if ((state.layoutType != LayoutType.list)) {
              _addComicListBlocEvent(
                  ChangeLayoutEvent(layoutType: LayoutType.list), context);
            }
          }
          return _resolveComicListState(state);
        });
      },
    );
  }

  void _addComicListBlocEvent(ComicListEvent event, BuildContext context) {
    final comicsListBloc = BlocProvider.of<ComicListBloc>(context);
    comicsListBloc.add(event);
  }

  void _addComicBlocEvent(ComicEvent event, BuildContext context) {
    final comicsPageBloc = BlocProvider.of<ComicBloc>(context);
    comicsPageBloc.add(event);
  }

  Widget _resolveComicListState(ComicListState state) {
    if (state is ComicListDataState) {
      if (state.layoutType == LayoutType.list) {
        return ComicsListMode(
          comicList: state.comics,
          onComicSelected: (comic) {},
        );
      } else {
        return ComicsGridMode(
          onComicSelected: (comic) {},
          comicList: state.comics,
        );
      }
    } else if (state is ComicListLoadingState) {
      return Container();
    } else if (state is ComicListErrorState) {
      return Container();
    } else {
      return Container();
    }
  }
}