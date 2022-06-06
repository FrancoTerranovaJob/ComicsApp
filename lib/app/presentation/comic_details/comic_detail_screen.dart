import 'package:comics_app/app/domain/comics_domain/entities/comic_detail.dart';
import 'package:comics_app/app/presentation/comic_details/bloc/comic_detail_bloc.dart';
import 'package:comics_app/app/presentation/comic_details/sections/characters/characters_section.dart';
import 'package:comics_app/app/presentation/comic_details/sections/image/image_section.dart';
import 'package:comics_app/app/presentation/comic_details/sections/locations/locations_section.dart';
import 'package:comics_app/app/presentation/comic_details/sections/teams/team_section.dart';
import 'package:comics_app/app/presentation/common/sizes/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComicDetailScreen extends StatelessWidget {
  const ComicDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComicDetailBloc, ComicDetailState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ComicDetailLoadingState) {
          return Container(
            color: Colors.white,
          );
        }
        return LayoutBuilder(builder: (context, constraint) {
          if (constraint.maxWidth <= AppSizes.splitLayoutWidthLimit) {
            return ComicDetailList(comicDetail: state.comicDetail);
          } else {
            return ComicDetailSplit(comicDetail: state.comicDetail);
          }
        });
      },
    );
  }
}

class ComicDetailSplit extends StatelessWidget {
  final ComicDetail comicDetail;
  const ComicDetailSplit({Key? key, required this.comicDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container()),
        Expanded(
            flex: 3,
            child: ListView(
              children: [
                CharacterSection(characters: comicDetail.characterCredits),
                TeamSection(teams: comicDetail.teamCredits),
                LocationSection(locations: comicDetail.locationCredits),
              ],
            )),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: SizedBox(
            width: 400,
            height: 700,
            child: ImageSection(
              imageUrl: comicDetail.originalImageUrl,
            ),
          ),
        ),
      ],
    );
  }
}

class ComicDetailList extends StatelessWidget {
  final ComicDetail comicDetail;
  const ComicDetailList({Key? key, required this.comicDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: SizedBox(
                width: 200,
                height: 300,
                child: ImageSection(
                  imageUrl: comicDetail.originalImageUrl,
                ),
              ),
            ),
            CharacterSection(characters: comicDetail.characterCredits),
            TeamSection(teams: comicDetail.teamCredits),
            LocationSection(locations: comicDetail.locationCredits),
          ],
        ))
      ],
    );
  }
}