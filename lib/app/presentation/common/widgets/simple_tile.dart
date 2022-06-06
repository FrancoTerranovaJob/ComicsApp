import 'package:flutter/material.dart';

class SimpleTile extends StatelessWidget {
  final Widget Function() getLeading;
  final Widget Function() getTitle;

  const SimpleTile({Key? key, required this.getLeading, required this.getTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: ListTile(
        leading: getLeading(),
        title: getTitle(),
      ),
    );
  }
}