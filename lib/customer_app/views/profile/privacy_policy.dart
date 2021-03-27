import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/customer_app/services/signup_user_service.dart';
class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Privacy Policy"),),
      body: Consumer<SignUpUserService>(
        builder: (context,data,child){
          return Column(
            children: [
              Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.name),
                          Text("Address : ${data.street} ${data.suit} ${data.city}"),
                          Text("Phone : ${data.phone}")
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                              child: Text(data.username == "Antonette" ? "1" : ""),
                            backgroundColor: Colors.black,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      )
    );
  }
}