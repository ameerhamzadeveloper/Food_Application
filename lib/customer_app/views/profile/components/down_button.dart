import 'package:flutter/material.dart';

class DownButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final IconData icon;
  DownButton({this.onTap, this.title, this.icon});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w400,),
      ),
      onTap: onTap,
    );
  }
}