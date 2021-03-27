import 'package:food_delivery_app/constants.dart';
import 'package:flutter/material.dart';

class IconContent extends StatelessWidget {
  final IconData icon;
  final String gender;
  IconContent({@required this.icon, this.gender});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 80.0,
          color: Colors.white,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          gender,
          style: textstyl,
        )
      ],
    );
  }
}
