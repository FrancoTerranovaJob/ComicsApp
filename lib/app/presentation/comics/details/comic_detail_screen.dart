import 'package:comics_app/app/presentation/comics/details/sections/characters/characters_section.dart';
import 'package:comics_app/app/presentation/comics/details/sections/locations/locations_section.dart';
import 'package:comics_app/app/presentation/comics/details/sections/teams/team_section.dart';
import 'package:comics_app/app/presentation/common/sizes/app_sizes.dart';
import 'package:flutter/material.dart';

class ComicDetailScreen extends StatelessWidget {
  const ComicDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth <= AppSizes.splitLayoutWidthLimit) {
        return ComicDetailList();
      } else {
        return ComicDetailSplitted();
      }
    });
  }
}

class ComicDetailSplitted extends StatelessWidget {
  const ComicDetailSplitted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container()),
        Expanded(
            flex: 3,
            child: ListView(
              children: const [
                CharacterSection(characters: []),
                TeamSection(teams: []),
                LocationSection(locations: []),
              ],
            )),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            width: 400,
            height: 700,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

class ComicDetailList extends StatelessWidget {
  const ComicDetailList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView(
          children: const [
            CharacterSection(characters: []),
            TeamSection(teams: []),
            LocationSection(locations: []),
          ],
        ))
      ],
    );
  }
}