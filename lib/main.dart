import 'package:comics_app/app/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'di/get_it.dart';

Future<void> main() async {
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comics App',
      theme: Theme.of(context),
      home: const HomePage(),
    );
  }
}