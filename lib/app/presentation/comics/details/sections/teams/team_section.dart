import 'package:comics_app/app/presentation/common/sizes/app_sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/comics_domain/entities/comic_detail.dart';
import '../../../../common/widgets/section.dart';
import '../../../../common/widgets/simple_tile.dart';

class TeamSection extends StatelessWidget {
  final List<Team> teams;
  const TeamSection({Key? key, required this.teams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getTeamSectionLayout(_getScreenSize(context));
  }

  double _getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  Widget _getTeamSectionLayout(double screenSize) {
    return TeamSectionSectionList();
  }
}

class TeamSectionSectionList extends StatelessWidget {
  const TeamSectionSectionList({Key? key}) : super(key: key);

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

class TeamSectionSectionGrid extends StatelessWidget {
  const TeamSectionSectionGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.deepOrangeAccent,
    );
  }
}