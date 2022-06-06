import 'package:comics_app/app/presentation/common/sizes/app_sizes.dart';
import 'package:comics_app/app/presentation/common/widgets/section.dart';
import 'package:comics_app/app/presentation/common/widgets/simple_tile.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/comics_domain/entities/comic_detail.dart';

class CharacterSection extends StatelessWidget {
  final List<Character> characters;
  const CharacterSection({Key? key, required this.characters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getCharacterLayout(_getScreenSize(context));
  }

  double _getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  Widget _getCharacterLayout(double screenSize) {
    return CharacterSectionList(
      characters: characters,
    );
  }
}

class CharacterSectionList extends StatelessWidget {
  final List<Character> characters;
  const CharacterSectionList({Key? key, required this.characters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Section<String>(
      contentWidget: (st) {
        return SimpleTile(
          getTitle: () {
            return Text(st);
          },
          getLeading: () {
            return Container(
              color: Colors.red,
              width: 50,
              height: 50,
            );
          },
        );
      },
      getTitle: () {
        return Text(
          'Characters',
          style: Theme.of(context).textTheme.headline3,
        );
      },
      getBodyContent: () {
        return List.generate(5, (index) => 'Hola $index');
      },
    );
  }
}

class CharacterSectionGrid extends StatelessWidget {
  const CharacterSectionGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      height: 450,
    );
  }
}