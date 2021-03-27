import 'package:flutter/material.dart';

class PersonalInputs extends StatelessWidget {
  final String hintText;
  final Function onTap;
  final TextInputType keyBordType;
  PersonalInputs({this.hintText, this.keyBordType, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextField(
          onChanged: onTap,
          keyboardType: keyBordType,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
