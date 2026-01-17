import 'package:flutter/material.dart';

class SaveButton extends StatefulWidget {
  const SaveButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.coloraccent
  });

  final Color coloraccent;
  final String label;
  final Function onPressed;

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              widget.onPressed();
            }, 
            style: ElevatedButton.styleFrom(
              foregroundColor: widget.coloraccent
            ),
            child: Text(
              widget.label,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}