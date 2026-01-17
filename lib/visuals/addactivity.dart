import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "package:mawknee/visuals/customforms/timefield.dart";
import "package:mawknee/visuals/customforms/univfield.dart";
import "package:mawknee/visuals/customforms/savebutton.dart";
import "package:mawknee/visuals/customforms/bottompopup.dart";

class ManualActivityAdder extends StatefulWidget {
  const ManualActivityAdder({super.key});

  @override
  State<ManualActivityAdder> createState() => _ManualActivityAdderState();
}

class _ManualActivityAdderState extends State<ManualActivityAdder> {
  
  String? date;
  String? time;
  double? amount;
  String? reason;

  @override
  Widget build(BuildContext context) {
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
            label: "type of activity", 
            onFieldChanged: (act) {
              reason = act;
            }, 
            type: TextInputType.text
          ),
          // Second Field
          UniversalField(
            label: "amount of money",
            onFieldChanged: (amount) {
              String money = amount;
              if(amount.contains(new RegExp(r',', caseSensitive: false))){
                money = amount.replaceAll(",",".");
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
                  mode: CupertinoDatePickerMode.time,
                  label: "time", 
                  onFieldChanged: (time) {
                    this.time = time;
                  }
                ),
              ),
              Flexible(
                child: CupertinoScrollField(
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
            label: "save activity", 
            onPressed: () {
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
                      "Not all fields are filled!"
                    )
                  );
                  return;
                }
              }
              if ((amount ?? 0.0) == 0.0) {
                ScaffoldMessenger.of(context).showSnackBar(
                    getSnackbar(
                      myIcon, 
                      "The amount must be unequal to zero!"
                    )
                  );
                  return;
              }


              Navigator.pop(context, [
                reason??"",
                amount??0,
                date??"",
                time??""
              ]);
            }
          )
        ]
      ),
    );
  }
}
