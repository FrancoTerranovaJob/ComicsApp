import 'package:comics_app/app/domain/comics_domain/entities/comic.dart';
import 'package:comics_app/app/domain/comics_domain/entities/comic_detail.dart';
import 'package:comics_app/app/presentation/comic_details/bloc/comic_detail_bloc.dart';
import 'package:comics_app/app/presentation/comics/bloc/comic_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/comics_domain/entities/comic_list.dart';
import '../../domain/comics_domain/entities/enum_layout_type.dart';
import '../comic_details/comic_detail_screen.dart';
import 'list/bloc/comic_list_bloc.dart';
import 'list/comic_list_screen.dart';

class ComicsPage extends StatelessWidget {
  const ComicsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comicBloc = BlocProvider.of<ComicBloc>(context);
    return BlocConsumer<ComicBloc, ComicState>(
      listener: (bContext, state) {
        if (state is ShowComicDetailState) {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => _pushComicDetail(context, state.comic!),
              ))
              .then((value) => comicBloc.add(OnPopComicDetail()));
        }
      },
      buildWhen: (p, c) => c is ShowComicListState,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => ComicListBloc(ComicListInitial(
              layoutType: LayoutType.list,
              comics: const ComicList(
                  comics: [],
                  offset: 0,
                  remainingComicsCount: 0,
                  pagesCount: 0),
              changeLayoutEnabled: true))
            ..add(SearchComicsEvent()),
          child: ComicListScreen(),
        );
      },
    );
  }

  Widget _pushComicDetail(BuildContext context, Comic comic) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
        ),
        body: SafeArea(
          child: BlocProvider(
            lazy: false,
            create: (context) => ComicDetailBloc(ComicDetailInitial(
                comic: comic,
                comicDetail: const ComicDetail(
                    originalImageUrl: '',
                    characterCredits: [],
                    teamCredits: [],
                    locationCredits: [])))
              ..add(SearchComicDetailEvent()),
            child: const ComicDetailScreen(),
          ),
        ),
      ),
    );
  }
}