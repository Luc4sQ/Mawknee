import "package:flutter/material.dart";
import "package:mawknee/visuals/addactivity.dart";
import "package:mawknee/visuals/home.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color coloraccent = Color.fromRGBO(27, 94, 32, 1);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/home",
      routes: {
        "/home": (context) => MyHomePage(
            title: "Mawknee",
            coloraccent: coloraccent,
          ),
        "/home/add": (context) => ManualActivityAdder(
          coloraccent: coloraccent,
        )
      },
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
      ),
    );
  }
}

