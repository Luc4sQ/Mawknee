import 'package:flutter/material.dart';

class UniversalField extends StatefulWidget {
  const UniversalField({
    super.key,
    required this.label,
    required this.onFieldChanged,
    required this.type
  });

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
        controller: fcontroller,
        keyboardType: widget.type,
        decoration: InputDecoration(
          border: OutlineInputBorder(), 
          labelText: widget.label
        ),
        onChanged: (string) => {
          widget.onFieldChanged(fcontroller.text)
        },
      ),
    );
  }
}