import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "package:mawknee/core/utils/date.dart";
import "package:mawknee/visuals/customforms/timefield.dart";
import "package:mawknee/visuals/customforms/univfield.dart";
import "package:mawknee/visuals/customforms/savebutton.dart";
import "package:mawknee/visuals/customforms/bottompopup.dart";
import "package:mawknee/database/databasehandler.dart";

class ManualActivityAdder extends StatefulWidget {
  const ManualActivityAdder({
    super.key,
    required this.coloraccent
  });

  final Color coloraccent;

  @override
  State<ManualActivityAdder> createState() => _ManualActivityAdderState();
}

class _ManualActivityAdderState extends State<ManualActivityAdder> {

  FinancialDatabaseConnector dbase = FinancialDatabaseConnector("finance");
  bool loaded = false;

  String? date;
  String? time;
  double? amount;
  String? reason;

  @override
  Widget build(BuildContext context) {

    // init only, if not already initialize
    dbase.isNull ? dbase.initDatabase().then((notinst) => { setState(() {
      loaded = true;
    })}) : 0;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("add activity"),
      ),
      body: Column(
        // First Field
        children: <Widget>[
          UniversalField(
            coloraccent: widget.coloraccent,
            label: "type of activity", 
            onFieldChanged: (act) {
              reason = act;
            }, 
            type: TextInputType.text
          ),
          // Second Field
          UniversalField(
            coloraccent: widget.coloraccent,
            label: "amount of money",
            onFieldChanged: (amount) {
              String money = amount;
              if(amount.contains(RegExp(r',', caseSensitive: false))){
                money = amount.replaceAll(",",".");
              }
              if (money == "-" || money == "") {
                return;
              }
              this.amount = double.parse(money);
            }, 
            type: TextInputType.numberWithOptions(
              decimal: true
            ),
          ),
          // Third and fourth field
          Row(
            children: <Widget>[
              Flexible(
                child: CupertinoScrollField(
                  coloraccent: widget.coloraccent,
                  mode: CupertinoDatePickerMode.time,
                  label: "time", 
                  onFieldChanged: (time) {
                    this.time = time;
                  }
                ),
              ),
              Flexible(
                child: CupertinoScrollField(
                  coloraccent: widget.coloraccent,
                  mode: CupertinoDatePickerMode.date,
                  label: "date",
                  onFieldChanged: (date) {
                    this.date = date;
                  },
                )
              ),
            ]
          ),
          SaveButton(
            coloraccent: widget.coloraccent,
            label: "save activity", 
            onPressed: () async {
              Icon myIcon = Icon(
                Icons.warning_amber_rounded,
                color: Colors.red[900],
                size: 30,
              );
              for (var entry in [reason??"", date??"", time??""]) {
                if (entry.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    getSnackbar(
                      myIcon, 
                      "Some fields are empty!",
                      Colors.red[200]
                    )
                  );
                  return;
                }
              }
              if ((amount ?? 0.0) == 0.0) {
                ScaffoldMessenger.of(context).showSnackBar(
                    getSnackbar(
                      myIcon, 
                      "The amount must be unequal to zero!",
                      Colors.red[200]
                    )
                  );
                  return;
              }

              DateTime parsedDate = parseDateTimeString(time??"00:00", date??"01.01.2000");

              if (!loaded) { return; }

              Map<String,Object?> data = {
                "amount": amount,
                "date": parsedDate.millisecondsSinceEpoch,
                "metadata": reason,
                "id": dbase.entries
              };

              dbase.insertData(data);
              
              Map datas = {
                "amount": amount,
                "date": parsedDate.millisecondsSinceEpoch,
                "metadata": reason,
                "id": dbase.entries
              };

              Navigator.pop(context, datas);
            }
          )
        ]
      ),
    );
  }
}
