import 'package:comics_app/app/domain/comics_domain/entities/comic_list.dart';
import 'package:comics_app/app/domain/comics_domain/entities/enum_layout_type.dart';
import 'package:comics_app/app/presentation/comics/bloc/comic_bloc.dart';
import 'package:comics_app/app/presentation/comics/details/comic_detail_screen.dart';
import 'package:comics_app/app/presentation/comics/list/bloc/comic_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'list/comic_list_screen.dart';

class ComicsPage extends StatelessWidget {
  const ComicsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComicBloc, ComicState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ShowComicListState) {
          return ComicDetailScreen();
          /* return BlocProvider(
            create: (context) => ComicListBloc(ComicListDataState(
                layoutType: LayoutType.list,
                comics: ComicList(
                    comics: [],
                    offset: 0,
                    remainingComicsCount: 0,
                    pagesCount: 0),
                changeLayoutEnabled: true)),
            child: ComicListScreen(),
          );*/
        } else if (state is ShowComicDetailState) {
          return Container(
            color: Colors.blue,
          );
        } else {
          return Container(
            color: Colors.blue,
          );
        }
      },
    );
  }
}