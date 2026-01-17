
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
  int pageindex = 0;


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
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: "IndahScript",
            fontSize: 60,
            color: Colors.green[600]
          )
        ),
        centerTitle: true,
      ),
      body: <Widget>[
        Center(
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
        Text("hi"),

      ][pageindex],
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.green[900],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        selectedIndex: pageindex,
        onDestinationSelected: (int index) {
          setState(() {
            pageindex = index;
          });
        },
        destinations: const <Widget> [
          NavigationDestination(
            icon: Icon(Icons.home_rounded), 
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.help_outline_sharp), 
            label: "Other")
        ]
      ),
      floatingActionButton: pageindex == 0 ? FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, "/home/add");
        },
        label: Text(
          "add activity",
          style: TextStyle(color: Colors.white),
        ),
        tooltip: 'Increment',
        backgroundColor: Colors.green[900],
        icon: const Icon(Icons.add, color: Colors.white),
      ) : null,
    );
  }
}
