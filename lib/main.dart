import 'package:flutter/material.dart';
import 'package:time_app/pages/home.dart';
import 'package:time_app/pages/loading.dart';
import 'package:time_app/pages/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World Time App',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      routes: {
        '/home': (context) => const Home(),
        '/': (context) => const Loading(),
        '/location': (context) => const Location(),
      },
    );
  }
}
