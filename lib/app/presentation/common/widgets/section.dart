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
    final widgetList = <Widget>[];
    var content = getBodyContent();
    widgetList.add(
      SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: getTitle(),
          )),
    );
    widgetList.add(const Divider());
    widgetList.addAll(List.generate(content.length, (index) {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: contentWidget(content[index]));
    }));

    return widgetList;
  }
}