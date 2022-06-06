import 'package:comics_app/app/presentation/common/sizes/app_sizes.dart';
import 'package:flutter/material.dart';

class ImageSection extends StatelessWidget {
  final ImageSection images;
  const ImageSection({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getImageSectionLayout(_getScreenSize(context));
  }

  double _getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  Widget _getImageSectionLayout(double screenSize) {
    if (screenSize <= AppSizes.sectionsWidthLimit) {
      return ImageSectionSectionList();
    } else {
      return ImageSectionSectionGrid();
    }
  }
}

class ImageSectionSectionList extends StatelessWidget {
  const ImageSectionSectionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ImageSectionSectionGrid extends StatelessWidget {
  const ImageSectionSectionGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}