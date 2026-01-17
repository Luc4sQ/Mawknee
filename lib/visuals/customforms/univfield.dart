import 'package:flutter/material.dart';

class UniversalField extends StatefulWidget {
  const UniversalField({
    super.key,
    required this.label,
    required this.onFieldChanged,
    required this.type,
    required this.coloraccent
  });

  final Color coloraccent;
  final String label;
  final Function onFieldChanged;
  final TextInputType type;

  @override
  State<UniversalField> createState() => _UniversalFieldState();
}

class _UniversalFieldState extends State<UniversalField> {
  
  TextEditingController fcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        cursorColor: Colors.white,
        controller: fcontroller,
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
          )
        ),
        onChanged: (string) => {
          widget.onFieldChanged(fcontroller.text)
        },
      ),
    );
  }
}