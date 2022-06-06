import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String message;
  final Function() onClose;
  const Message({Key? key, required this.message, required this.onClose})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              child: Container(
            width: 500,
            height: 300,
            color: Colors.white,
            child: Center(
              child: Text(
                message,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          )),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                onClose();
              },
              child: Text(
                "CLOSE",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
            ),
          ))
        ],
      ),
    );
  }
}