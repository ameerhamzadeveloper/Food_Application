import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';

class WelcomeButtons extends StatelessWidget {
  final String title;
  final Function onTap;
  final IconData icon;
  WelcomeButtons({this.onTap, this.title, this.icon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        // left: 15.0,
        // right: 8.0,
      ),
      child: MaterialButton(
          height: 50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          color: kThemeColor,
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
