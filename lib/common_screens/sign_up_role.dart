import 'package:flutter/material.dart';
import 'package:food_delivery_app/common_screens/components/roles_card.dart';
import 'package:food_delivery_app/routes/routes_names.dart';
import 'package:food_delivery_app/models/sign_up_model.dart';
import 'package:provider/provider.dart';


class SignRole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<SignUpModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  "Please Select A Role",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  RoleCard(
                    title: "I'm Customer",
                    image: "images/user.png",
                    onTap: () {
                      Navigator.pushNamed(context, createProfile);
                      pro.roleUpdate(1);
                    },
                  ),
                  RoleCard(
                    title: "As a Resturant",
                    image: "images/resturentIcon.png",
                    onTap: () {
                      Navigator.pushReplacementNamed(context, resturantGeneralInfo);
                      pro.roleUpdate(2);
                    },
                  ),
                ],
              ),
              RoleCard(
                title: "I'm Delivery-Boy",
                image: "images/deliveryBoy.png",
                onTap: () {
                  pro.roleUpdate(3);
                  Navigator.pushReplacementNamed(context, deliDocuments);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
