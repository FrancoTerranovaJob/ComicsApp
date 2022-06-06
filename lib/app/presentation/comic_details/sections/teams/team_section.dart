import 'package:flutter/material.dart';

import '../../../../domain/comics_domain/entities/comic_detail.dart';
import '../../../common/widgets/section.dart';
import '../../../common/widgets/simple_tile.dart';

class TeamSection extends StatelessWidget {
  final List<Team> teams;
  const TeamSection({Key? key, required this.teams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Section<Team>(
      contentWidget: (team) {
        return SimpleTile(
          getTitle: () {
            return Text(team.name);
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
          'Teams',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
        );
      },
      getBodyContent: () {
        return teams;
      },
    );
  }
}