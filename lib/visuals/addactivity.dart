import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ManualActivityAdder extends StatefulWidget {
  const ManualActivityAdder({super.key});

  @override
  State<ManualActivityAdder> createState() => _ManualActivityAdderState();
}

class _ManualActivityAdderState extends State<ManualActivityAdder> {
  TextEditingController datefield = TextEditingController();
  TextEditingController timefield = TextEditingController();

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        // Provide a background color for the popup.
        color: Theme.of(context).colorScheme.inversePrimary,
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(top: false, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("add activity"),
      ),
      body: Column(
        children: <Widget>[
          CustomFormField(
            label: "type of activity",
            mkt: TextInputType.text,
          ),
          CustomFormField(
            label: "amount of money",
            mkt: TextInputType.numberWithOptions(
              decimal: true
            ),
          ),
          Row(
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: datefield,
                    onTap: () => _showDialog(
                      CupertinoDatePicker(
                        //initialDateTime: date,
                        mode: CupertinoDatePickerMode.date,
                        use24hFormat: true,
                        // This shows day of week alongside day of month
                        showDayOfWeek: false,
                        // This is called when the
                        onDateTimeChanged: (date) => {
                          setState(() {
                            datefield.text = "${date.year.toString()}-${date.month.toString()}-${date.day.toString()}";
                          })
                        }
                      )
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(), 
                      labelText: "date"
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: timefield,
                    onTap: () => _showDialog(
                      CupertinoDatePicker(
                        //initialDateTime: date,
                        mode: CupertinoDatePickerMode.time,
                        use24hFormat: true,
                        // This shows day of week alongside day of month
                        showDayOfWeek: false,
                        // This is called when the
                        onDateTimeChanged: (date) => {
                          setState(() {
                            String hour = date.hour < 10 ? "0${date.hour.toString()}" : date.hour.toString();
                            String min = date.minute < 10 ? "0${date.minute.toString()}" : date.minute.toString();
                            timefield.text = "$hour:$min";
                          })
                        }
                      )
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(), 
                      labelText: "time"
                    ),
                  ),
                ),
              ),
            ]
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {}, 
                  child: Text(
                    "save activity",
                    style: TextStyle(color: Colors.white),
                  )
                )
              ],
            ),
          ),
        ]
      ),
    );
  }
}

class CustomFormField extends StatelessWidget {

  final String label;
  final TextInputType mkt;

  const CustomFormField({
    super.key,
    required this.label,
    required this.mkt
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        keyboardType: mkt,
        decoration: InputDecoration(
          border: OutlineInputBorder(), 
          labelText: label
        ),
      ),
    );
  }
}