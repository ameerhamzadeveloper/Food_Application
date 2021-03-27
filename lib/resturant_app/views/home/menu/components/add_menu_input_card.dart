import 'package:flutter/material.dart';

class AddMenuInputsCard extends StatelessWidget {
  final String hintText;
  final Function onTap;
  final TextEditingController controller;

  AddMenuInputsCard({this.hintText, this.onTap,this.controller});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextField(
          onChanged: onTap,
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