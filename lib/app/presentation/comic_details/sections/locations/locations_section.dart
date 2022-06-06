import 'package:flutter/material.dart';

import '../../../../domain/comics_domain/entities/comic_detail.dart';
import '../../../common/widgets/section.dart';
import '../../../common/widgets/simple_tile.dart';

class LocationSection extends StatelessWidget {
  final List<LocationCredits> locations;
  const LocationSection({Key? key, required this.locations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Section<LocationCredits>(
      contentWidget: (loc) {
        return SimpleTile(
          getTitle: () {
            return Text(loc.name);
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
          'Locations',
          style: Theme.of(context).textTheme.headlineMedium,
        );
      },
      getBodyContent: () {
        return locations;
      },
    );
  }
}