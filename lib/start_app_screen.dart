import 'package:flutter/material.dart';
import 'package:flutter_walkthrough/flutter_walkthrough.dart';
import 'package:flutter_walkthrough/walkthrough.dart';
import 'package:food_delivery_app/common_screens/sign_up_welcome_screen.dart';
import 'package:food_delivery_app/customer_app/views/profile/profile.dart';

ProfileView profileView = ProfileView();

class StartAppScreen extends StatefulWidget {
  @override
  _StartAppScreenState createState() => _StartAppScreenState();
}

class _StartAppScreenState extends State<StartAppScreen> {
  final List<Walkthrough> list = [
    Walkthrough(
      title: "Hungrey?",
      content: "Hungrey? Let's Enjoy the food",
      imageIcon: Icons.restaurant_menu,
    ),
    Walkthrough(
      title: "Find Resturants",
      content: "Eat From your favoruit resturants",
      imageIcon: Icons.search,
    ),
    Walkthrough(
      title: "Buy From Grocery Stores",
      content: "Need to buy some things from Grocery Store?",
      imageIcon: Icons.shopping_cart,
    ),
    Walkthrough(
      title: "Everything is ok",
      content: "Let's Enjoy the foods...",
      imageIcon: Icons.verified_user,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroScreen(
      list,
      MaterialPageRoute(builder: (context) => SignUpWelcome()),
    );
  }
}
