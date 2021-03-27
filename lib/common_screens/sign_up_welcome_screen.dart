import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:food_delivery_app/common_screens/components/welcome_button.dart';
import 'package:food_delivery_app/routes/routes_names.dart';

class SignUpWelcome extends StatelessWidget {

  final Widget imageCoursel = Container(
    height: 150,
    child: Carousel(
      dotBgColor: Colors.transparent,
      dotColor: Colors.transparent,
      showIndicator: false,
      boxFit: BoxFit.fill,
      images: [
        AssetImage("images/foodInPlate.png"),
        AssetImage("images/food.png"),
        AssetImage("images/foodorder.png"),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff515254),
              // Colors.red,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 300,
              width: 300,
              child: imageCoursel,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 15.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Hey, Welcome here!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      "You're important for us! we have foods for you in cheapest prices.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    WelcomeButtons(
                      title: "Continue with Phone",
                      onTap: () {
                        Navigator.pushNamed(context, phoneSignUp);
                      },
                      icon: Icons.phone,
                    ),
                    WelcomeButtons(
                        title: "Continue with Email",
                        onTap: () {
                          Navigator.pushNamed(context, emailSignUp);
                        },
                        icon: Icons.email),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
