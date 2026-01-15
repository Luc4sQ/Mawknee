import "package:flutter/material.dart";
import "package:mawknee/visuals/home.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 9, 223, 55)),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

