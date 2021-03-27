import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularIndicator extends StatelessWidget {
  final String title;
  final double percent;
  final String prcntiner;
  final Color color;
  CircularIndicator({this.title, this.percent, this.prcntiner, this.color});
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 60.0,
      lineWidth: 5.0,
      animation: true,
      percent: percent,
      center: new Text(
        prcntiner,
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
      ),
      footer: new Text(
        title,
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: color,
    );
  }
}
