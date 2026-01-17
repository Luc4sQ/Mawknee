import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "package:mawknee/visuals/customforms/timefield.dart";
import "package:mawknee/visuals/customforms/univfield.dart";
import "package:mawknee/visuals/customforms/savebutton.dart";

class ManualActivityAdder extends StatefulWidget {
  const ManualActivityAdder({super.key});

  @override
  State<ManualActivityAdder> createState() => _ManualActivityAdderState();
}

class _ManualActivityAdderState extends State<ManualActivityAdder> {
  TextEditingController datefield = TextEditingController();
  TextEditingController timefield = TextEditingController();
  
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
            onFieldChanged: (test) {}, 
            type: TextInputType.text
          ),
          // Second Field
          UniversalField(
            label: "amount of money",
            onFieldChanged: (test) {}, 
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
                  onFieldChanged: (test) {}
                ),
              ),
              Flexible(
                child: CupertinoScrollField(
                  mode: CupertinoDatePickerMode.date,
                  label: "date",
                  onFieldChanged: (test) {},
                )
              ),
            ]
          ),
          SaveButton(
            label: "save activity", 
            onPressed: () {

            }
          )
        ]
      ),
    );
  }
}
