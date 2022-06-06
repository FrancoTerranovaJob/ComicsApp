import 'package:flutter/material.dart';

class ImageSection extends StatelessWidget {
  final String imageUrl;
  const ImageSection({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isNotEmpty) {
      return Image.network(imageUrl);
    } else {
      return const Center(
        child: Text('Image not found/Unable to load'),
      );
    }
  }
}