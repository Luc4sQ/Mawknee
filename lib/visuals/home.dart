
import "dart:math";

import 'package:flutter/material.dart';
import "package:mawknee/visuals/homesplit/barbar.dart";
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
        data.isEmpty ? Center(
          child: LoadingAnimationWidget.twistingDots(
            leftDotColor: const Color(0xFF1A1A3F),
            rightDotColor: const Color(0xFFEA3799),
            size: 200,
          ),
        ) : ListView.builder(
        itemBuilder: (_,index) {
          if (index < data.length){
            return Padding(
              padding: EdgeInsets.all(3),
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                elevation: 3,
                color: const Color.fromARGB(255, 19, 44, 19),
                shadowColor: Colors.black,
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                    ),
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 0, bottom: 0, left: 0, right: 0),
                    decoration:  BoxDecoration(
                      border: Border(
                        left: data[index].isIncome 
                        ? BorderSide(color: Colors.green, width: 8)
                        : BorderSide(color: Colors.red, width: 8),
                      ),
                    ),
                    child: ListTile(
                      style: ListTileStyle.list,
                      title: Text(data[index].metadata??""),
                      subtitle: Text("${data[index].transaction.toString()} €"),
                      trailing: Text(data[index].date.toString().replaceAll(":00.000", "")),
                    ),
                  ),
                ),
              ),
            );
          }   
        }
      ),
      Center(
        child: Text(
          "Still in development."
        )
      )
      ][pageindex],

      // navigator
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
