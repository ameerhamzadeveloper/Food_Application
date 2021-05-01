import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/profile_provider.dart';
import 'package:food_delivery_app/customer_app/views/profile/components/profile_page_buttons.dart';
import 'package:food_delivery_app/main.dart';
import 'package:food_delivery_app/resturant_app/views/signup/personal_information.dart';
import 'package:food_delivery_app/routes/routes_names.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String name;
  String phone;
  String image;
  String address;
  bool isLoaded = false;
  bool translationBtnVal = false;

  void changeLanguage() {
    if (translationBtnVal == true) {
      final local = Locale('ar', 'SA');
      MyApp.setLocale(context, local);
    } else {
      final local = Locale('en', 'US');
      MyApp.setLocale(context, local);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: <Widget>[
                      ClipOval(
                          child: provider.diaplayImage == null ?
                          Image.asset(
                            "images/profile.png",
                            height: 50,
                            width: 50,
                            fit: BoxFit.fill,
                          ):
                              Image.network('https://tripps.live/tripp_food/${provider.diaplayImage}',height: 50,width: 50,fit: BoxFit.fill,)
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        provider.displayName ??  "Loading...",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.call,
                        color: kThemeColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        provider.displayPhone ?? "Loading...",
                        style: TextStyle(fontSize: 15.0),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(
                            Icons.home,
                            color: kThemeColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${provider.displayHouseNo} ${provider.displayStreet} ${provider.displayArea} ${provider.displayCity}" ?? "Loading...",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                            maxLines: 3,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // provider.fetchUserProfile();
                              // print(provider.userid);
                              provider.myTotalOrders();

                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 8, left: 10, right: 10),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 2.0,
                ),
                ProfilePageButton(
                  title: kGetTranslated(context, 'feedback'),
                  icon: Icons.feedback,
                  routeName: feedBack,
                ),
                ProfilePageButton(
                  title: kGetTranslated(context, 'help'),
                  icon: Icons.help,
                  routeName: help,
                ),
                ProfilePageButton(
                  title: kGetTranslated(context, 'privacy_policy'),
                  icon: Icons.privacy_tip,
                  routeName: privacyPolicy,
                ),
                ProfilePageButton(
                  title: kGetTranslated(context, 'about_us'),
                  icon: Icons.info,
                  routeName: aboutUs,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("English 🇺🇸󠁧󠁢"),
                        Switch(
                          activeColor: kThemeColor,
                          value: translationBtnVal,
                          onChanged: (val) {
                            setState(() {
                              translationBtnVal = val;
                              changeLanguage();
                            });
                          },
                        ),
                        Text("العربي 🇸🇦")
                      ],
                    ),
                    FlatButton(
                      onPressed: () {
                        provider.logout(context);
                      },
                      child: Row(
                        children: [
                          Text(kGetTranslated(context, 'logout')),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.exit_to_app)
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0xffE2E7E7)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text("1.0.20"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
