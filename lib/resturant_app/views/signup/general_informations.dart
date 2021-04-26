import 'dart:io';
import 'dart:math';
import 'package:food_delivery_app/resturant_app/views/profile/profile.dart';
import 'package:food_delivery_app/resturant_app/views/signup/components/general_detail_card.dart';
import 'package:food_delivery_app/resturant_app/views/signup/components/general_information_card_contnet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/resturant_app/views/signup/personal_information.dart';
import 'package:food_delivery_app/routes/routes_names.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/resturant_app/model/resturant_profile_provider.dart';


class ResturantGeneralInfo extends StatefulWidget {
  @override
  _ResturantGeneralInfoState createState() => _ResturantGeneralInfoState();
}

class _ResturantGeneralInfoState extends State<ResturantGeneralInfo> {

  // getting location of resturant
  void getLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final provi = Provider.of<ResturantProfileProvider>(context,listen: false);
    provi.getIdEmail();
    provi.lat = position.latitude;
    provi.long = position.longitude;
    print(provi.long);
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ResturantProfileProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Submit Your Documents",
                style: kTopLebelStyle,
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Cards(
                        ontap: () {
                          provider.pickSelfieImage();
                        },
                        colour: kThemeColor,
                        cardChild: provider.selfieImage == null
                            ? IconContent(
                          icon: Icons.camera_alt,
                          gender: "Your Selfie",
                        )
                            : provider.showSelfieImage(),
                      ),
                    ),
                    Expanded(
                      child: Cards(
                        ontap: () {
                          provider.pickResturantImage();
                        },
                        colour: kThemeColor,
                        cardChild: provider.resturantImage == null
                            ? IconContent(
                          icon: Icons.camera_alt,
                          gender: "Resturant Logo",
                        )
                            : provider.showResturantImage(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Cards(
                        ontap: () {
                          provider.pickCnicFonrtImage();
                        },
                        colour: kThemeColor,
                        cardChild: provider.cnicFront == null
                            ? IconContent(
                          icon: Icons.camera_alt,
                          gender: "CNIC Front",
                        )
                            : provider.showCnicFonrtImage(),
                      ),
                    ),
                    Expanded(
                      child: Cards(
                        ontap: () {
                          provider.pickCnicBackImage();
                        },
                        colour: kThemeColor,
                        cardChild: provider.cnicBack == null
                            ? IconContent(
                          icon: Icons.camera_alt,
                          gender: "CNIC Back",
                        )
                            : provider.showCnicBackImage(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 50,
                onPressed: () {
                  Navigator.pushNamed(context, resturantPersonalInfo);
                  provider.getIdEmail();
                },
                color: kThemeColor,
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}