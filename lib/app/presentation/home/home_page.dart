import 'package:comics_app/app/presentation/comics/bloc/comic_bloc.dart';
import 'package:comics_app/app/presentation/comics/comics_page.dart';
import 'package:comics_app/app/presentation/comics/list/comic_list_screen.dart';
import 'package:comics_app/app/domain/comics_domain/entities/enum_layout_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(child: Center(child: Text('COMIC BOOK'))),
          Expanded(
            flex: 5,
            child: BlocProvider(
              lazy: false,
              create: (context) => ComicBloc(ShowComicListState()),
              child: const ComicsPage(),
            ),
          ),
        ],
      )),
    );
  }
}