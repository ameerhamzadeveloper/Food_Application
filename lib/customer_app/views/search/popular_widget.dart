import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
TextStyle topKeyWodStyle = TextStyle(color: kThemeColor);
class PopularWidget extends StatelessWidget {
  final String name;
  final Function onTap;
  const PopularWidget({Key key, this.name, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(name,style: topKeyWodStyle,),
        ),
      ),
    );
  }
}
