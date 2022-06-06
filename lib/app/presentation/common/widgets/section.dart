import 'package:flutter/material.dart';

class Section<T> extends StatelessWidget {
  final Widget Function() getTitle;
  final List<T> Function() getBodyContent;
  final Widget Function(T item) contentWidget;
  const Section(
      {Key? key,
      required this.getTitle,
      required this.getBodyContent,
      required this.contentWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: _getContent(),
    );
  }

  List<Widget> _getContent() {
    var content = getBodyContent();
    if (content.isEmpty) {
      content = [];
    }
    return List.generate(content.length, (index) {
      if (index == 0) {
        return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: getTitle(),
            ));
      } else {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: contentWidget(content[index]),
        );
      }
    });
  }
}