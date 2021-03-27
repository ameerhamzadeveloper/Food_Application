import 'package:flutter/material.dart';

class AddMenuInputs extends StatelessWidget {
  final String hintText;
  final Function onTap;
  final TextEditingController controller;
  AddMenuInputs({this.hintText, this.onTap,this.controller});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextField(
          onChanged: onTap,
          autofocus: true,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
