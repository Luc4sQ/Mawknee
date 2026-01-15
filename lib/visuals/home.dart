import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import "package:mawknee/database/databasehandler.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FinancialDatabaseConnector dbase =  FinancialDatabaseConnector("test");
  bool loaded = false;

  void _incrementCounter() async {

    await dbase.insertDummy(dbase.length);
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {

    // init only, if not already initialize
    dbase.isNull ? dbase.initDatabase().then((notinst) => { setState(() {
      loaded = true;
    })}) : 0;

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [  
            const Text('You have pushed the button this many times:'), 
            
            loaded ? Text(
              '${dbase.length}', style: Theme.of(context).textTheme.headlineMedium,
            ) : LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.grey,
              size: 100,
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
