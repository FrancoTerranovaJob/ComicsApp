import 'package:comics_app/app/presentation/common/widgets/section.dart';
import 'package:comics_app/app/presentation/common/widgets/simple_tile.dart';
import 'package:flutter/material.dart';

import '../../../../domain/comics_domain/entities/comic_detail.dart';

class CharacterSection extends StatelessWidget {
  final List<Character> characters;
  const CharacterSection({Key? key, required this.characters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Section<Character>(
      contentWidget: (chr) {
        return SimpleTile(
          getTitle: () {
            return Text(chr.name);
          },
          getLeading: () {
            return const SizedBox(
              width: 50,
              height: 50,
            );
          },
        );
      },
      getTitle: () {
        return Text(
          'Characters',
          style: Theme.of(context).textTheme.headlineMedium,
        );
      },
      getBodyContent: () {
        return characters;
      },
    );
  }
}