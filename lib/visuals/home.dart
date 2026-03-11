import 'package:flutter/material.dart';
import "package:mawknee/visuals/homesplit/mawnavigationbar.dart";
import "package:mawknee/visuals/homesplit/mawmoneyviewrectangle.dart";
import "package:mawknee/database/databasehandler.dart";
import "package:mawknee/core/moneyactivity.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key, 
    required this.title,
    required this.coloraccent
  });

  final String title;
  final Color coloraccent;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FinancialDatabaseConnector dbase = FinancialDatabaseConnector("finance");
  static List<MoneyActivity> data = [];
  List<Color> colors = [Colors.grey, Colors.brown];
  bool loaded = false;


  int pageindex = 0;
  


  @override
  Widget build(BuildContext context) {

    // init only, if not already initialize
    dbase.isNull ? dbase.initDatabase().then((notinst) async { 
      loaded = true;
      List<Map> rawdata = await dbase.getData();
      List<MoneyActivity> tmp = [];
      for (var row in rawdata) {
        tmp.add(MoneyActivity(
          row["amount"],
          date: DateTime.fromMillisecondsSinceEpoch(row["date"]),
          metadata: row["metadata"]
        ));
      }
      data = tmp;
      setState(() {});
    }) : 0;

    return Scaffold(
      
      // the header of the whole app (TODO: change to a more responsive design)
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: "IndahScript",
            fontSize: 60,
            color: widget.coloraccent
          )
        ),
        centerTitle: true,
      ),

      // where all is shown
      body: <Widget>[
        RectangleMoneyview(
          data: data
        ),
        Text(""),
        Center(
          child: Text(
            "Still in development."
          )
        )
      ][pageindex],

      // custom navigationbar, which adjusts the index for the array above
      bottomNavigationBar: BarBar(
        coloraccent: widget.coloraccent, 
        onStateChanged: (ind) {
          setState(() {
            pageindex = ind;
          });
        }
      ),

      // button to add new stuff
      floatingActionButton: pageindex == 0 ? FloatingActionButton.extended(
        onPressed: () async {
          dynamic rawdata = await Navigator.pushNamed(context, "/home/add");
          rawdata != null ? data.add(MoneyActivity(
            rawdata?["amount"],
            date: DateTime.fromMillisecondsSinceEpoch(rawdata?["date"]),
            metadata: rawdata?["metadata"]
            )
          ) : true;
          data.sort((b,a) => a.date!.compareTo(b.date!));
          setState(() {
            
          });
        },
        label: Text(
          "add activity",
          style: TextStyle(),//color: Colors.white),
        ),
        tooltip: 'Increment',
        backgroundColor: widget.coloraccent,
        icon: const Icon(Icons.add),
      ) : null,
    );
  }
}
