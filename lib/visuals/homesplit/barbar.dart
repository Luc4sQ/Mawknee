import 'package:flutter/material.dart';

class BarBar extends StatefulWidget {
  const BarBar({
    super.key,
    required this.coloraccent,
    required this.onStateChanged
  });

  final Color coloraccent;
  final Function onStateChanged;

  @override
  State<BarBar> createState() => _BarBarState();
}

class _BarBarState extends State<BarBar> {

  int myIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      indicatorColor: widget.coloraccent,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      selectedIndex: myIndex,
      onDestinationSelected: (int index) {
        setState(() {
          myIndex = index;
          widget.onStateChanged(index);
        });
      },
      destinations: const <Widget> [
        NavigationDestination(
          icon: Icon(Icons.home_rounded), 
          label: "Home",
        ),
        NavigationDestination(
          icon: Icon(Icons.help_outline_sharp), 
          label: "Other")
      ]
    );
  }
}