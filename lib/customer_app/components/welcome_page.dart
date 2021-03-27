import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';

class WelcomePage extends StatelessWidget {
  final String image;
  final String buttonTitle;
  final Function ontap;
  WelcomePage({this.ontap, this.buttonTitle, this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fill,
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: MaterialButton(
                  shape: StadiumBorder(),
                  color: kThemeColor,
                  elevation: 20.0,
                  padding: EdgeInsets.all(8.0),
                  height: 40,
                  minWidth: MediaQuery.of(context).size.width / 2,
                  onPressed: ontap,
                  child: Text(
                    buttonTitle,
                    style: kWhiteTextColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
