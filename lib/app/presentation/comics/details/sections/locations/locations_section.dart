import 'package:comics_app/app/presentation/common/sizes/app_sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/comics_domain/entities/comic_detail.dart';
import '../../../../common/widgets/section.dart';
import '../../../../common/widgets/simple_tile.dart';

class LocationSection extends StatelessWidget {
  final List<LocationCredits> locations;
  const LocationSection({Key? key, required this.locations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getLocationSectionLayout(_getScreenSize(context));
  }

  double _getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  Widget _getLocationSectionLayout(double screenSize) {
    return LocationSectionSectionList();
  }
}

class LocationSectionSectionList extends StatelessWidget {
  const LocationSectionSectionList({Key? key}) : super(key: key);

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

class LocationSectionSectionGrid extends StatelessWidget {
  const LocationSectionSectionGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purpleAccent,
      height: 100,
    );
  }
}