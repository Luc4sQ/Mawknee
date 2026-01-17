import 'package:flutter/material.dart';

SnackBar getSnackbar(
  Icon setIcon,
  String label, {
    int duration = 2,
    double width = 400,
  }) {

return SnackBar(
  content: Row(
    children: [
      setIcon,
      Padding(
        padding: EdgeInsetsDirectional.all(8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18
          ),
        ),
      )
    ],
  ),
  showCloseIcon: false,
  width: width,
  behavior: SnackBarBehavior.floating,
  duration: Duration(seconds: duration),
);
}



