import 'package:flutter/material.dart';
import "package:mawknee/core/moneyactivity.dart";
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RectangleMoneyview extends StatefulWidget {
  const RectangleMoneyview({
    super.key,
    required this.data
  });

  final List<MoneyActivity> data;

  @override
  State<RectangleMoneyview> createState() => _RectangleMoneyviewState();
}

class _RectangleMoneyviewState extends State<RectangleMoneyview> {
  
  @override
  Widget build(BuildContext context) {
    
    return widget.data.isEmpty ? Center(
        child: LoadingAnimationWidget.twistingDots(
          leftDotColor: const Color(0xFF1A1A3F),
          rightDotColor: const Color(0xFFEA3799),
          size: 200,
        ),
      ) : ListView.builder(
      itemBuilder: (_,index) {
        if (index < widget.data.length){
          return Padding(
            padding: EdgeInsets.all(3),
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              elevation: 3,
              color: const Color.fromARGB(255, 19, 44, 19),
              shadowColor: Colors.black,
              child: ClipPath(
                clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                  ),
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 0, bottom: 0, left: 0, right: 0),
                  decoration:  BoxDecoration(
                    border: Border(
                      left: widget.data[index].isIncome 
                      ? BorderSide(color: Colors.green, width: 8)
                      : BorderSide(color: Colors.red, width: 8),
                    ),
                  ),
                  child: ListTile(
                    style: ListTileStyle.list,
                    title: Text(widget.data[index].metadata??""),
                    subtitle: Text("${widget.data[index].transaction.toString()} €"),
                    trailing: Text(widget.data[index].date.toString().replaceAll(":00.000", "")),
                  ),
                ),
              ),
            ),
          );
        } else {
          return null;
        }
      }
    );
  }
}