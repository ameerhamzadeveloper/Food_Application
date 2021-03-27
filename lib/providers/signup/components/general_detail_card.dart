import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final Color colour;
  final Widget cardChild;
  final Function ontap;
  Cards({@required this.colour, this.cardChild, this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          child: cardChild,
          margin: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: colour, borderRadius: BorderRadius.circular(15))),
    );
  }
}
