import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
class AllTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kThemeColor,
        title: Text(
          kGetTranslated(context, 'recent_transactions')
        ,style: TextStyle(color: Colors.black),),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Card(
              elevation: 5.0,
              child: Column(
                children: [
                  ListTile(
                    title: Text("SR 100"),
                    subtitle: Text("Arabic Resturant"),
                    trailing: Text("12/12/2020"),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 5.0,
              child: Column(
                children: [
                  ListTile(
                    title: Text("SR 100"),
                    subtitle: Text("Arabic Resturant"),
                    trailing: Text("12/12/2020"),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 5.0,
              child: Column(
                children: [
                  ListTile(
                    title: Text("SR 100"),
                    subtitle: Text("Arabic Resturant"),
                    trailing: Text("12/12/2020"),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 5.0,
              child: Column(
                children: [
                  ListTile(
                    title: Text("SR 100"),
                    subtitle: Text("Arabic Resturant"),
                    trailing: Text("12/12/2020"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
