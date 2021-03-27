import 'package:flutter/material.dart';
import 'package:food_delivery_app/customer_app/views/profile/components/down_button.dart';

class ProfilePageButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final String routeName;
  ProfilePageButton({this.title, this.icon, this.routeName});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DownButton(
          onTap: () {
            Navigator.pushNamed(context, routeName);
          },
          title: title,
          icon: icon,
        ),
        Divider(),
      ],
    );
  }
}
