import 'package:flutter/material.dart';

class ResturantWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tripp Wallet"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Your Wallet"),
                Icon(Icons.money)
              ],
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Text("Your Balance"),
                  Text("0 SAR",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
