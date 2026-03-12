import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UniversalField extends StatefulWidget {
  const UniversalField({
    super.key,
    required this.label,
    required this.onFieldChanged,
    required this.type,
    required this.coloraccent,
    required this.text,
    required this.inputformat
  });

  final Color coloraccent;
  final String label;
  final Function onFieldChanged;
  final TextInputType type;
  final String text;
  final TextInputFormatter inputformat;

  @override
  State<UniversalField> createState() => _UniversalFieldState();
}

class _UniversalFieldState extends State<UniversalField> {
  
  TextEditingController fcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    fcontroller.text = widget.text;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        cursorColor: Colors.white,
        controller: fcontroller,
        inputFormatters: [widget.inputformat],
        keyboardType: widget.type,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(
              color: widget.coloraccent
            ),
          ),
          focusedBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(
              color: widget.coloraccent,
              width: 3
            ),
          ),
          border: OutlineInputBorder(), 
          labelText: widget.label,
          labelStyle: TextStyle(
            color: Colors.white
          ),
          floatingLabelStyle: TextStyle(
            color: Colors.white
          ),
        ),
        onChanged: (_) {
          widget.onFieldChanged(fcontroller.text);
        },
      ),
    );
  }
}

class UniversField extends StatelessWidget {
  UniversField({
    super.key,
    required this.label,
    required this.onFieldChanged,
    required this.type,
    required this.coloraccent,
    required this.text
  });

  final Color coloraccent;
  final String label;
  final Function onFieldChanged;
  final TextInputType type;
  final String text;

  final TextEditingController fcontroller = TextEditingController(text:"fsadfs");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        cursorColor: Colors.white,
        controller: fcontroller,
        keyboardType: type,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(
              color: coloraccent
            ),
          ),
          focusedBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(
              color: coloraccent,
              width: 3
            ),
          ),
          border: OutlineInputBorder(), 
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.white
          ),
          floatingLabelStyle: TextStyle(
            color: Colors.white
          ),
        ),
        onChanged: (test) => {
          onFieldChanged(fcontroller.text)
        },
      ),
    );
  }
}