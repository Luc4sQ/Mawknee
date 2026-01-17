import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "package:mawknee/core/utils/date.dart";


class CupertinoScrollField extends StatefulWidget {
  const CupertinoScrollField({
    required this.mode,
    required this.label, 
    required this.onFieldChanged,
    super.key
  });

  final CupertinoDatePickerMode mode;
  final Function onFieldChanged;
  final String label;

  @override
  State<CupertinoScrollField> createState() => _CupertinoScrollFieldState();
}

class _CupertinoScrollFieldState extends State<CupertinoScrollField> {
  
  TextEditingController fcontroller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        readOnly: true,
        controller: fcontroller,
        onTap: () => showCupertinoModalPopup<void>(
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
            child: SafeArea(
              top: false, 
              child: CupertinoDatePicker(
                //initialDateTime: date,
                mode: widget.mode,
                use24hFormat: true,
                // This shows day of week alongside day of month
                showDayOfWeek: false,
                // This is called when the
                onDateTimeChanged: (date) => {
                  setState(() {
                    Map<String,String> map = getNormalizedDateTimeString(date);
                    fcontroller.text = map[widget.label] ?? "";
                    widget.onFieldChanged(fcontroller.text);
                  })
                }
              )
            ),
          ),
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(), 
          labelText: widget.label
        ),
      ),
    );
  }
}