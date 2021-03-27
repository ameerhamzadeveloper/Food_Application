import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/profile_provider.dart';
import 'package:provider/provider.dart';
class AddAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Address"),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onChanged: (val){
                          pro.setHouse(val);
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText:"House No"
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: TextField(
                        onChanged: (val){
                          pro.setStreet(val);
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText:"Street No"
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                TextField(
                  onChanged: (val){
                    pro.setArea(val);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText:"Area"
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  onChanged: (val){
                    pro.setCity(val);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText:"City"
                  ),
                ),
                SizedBox(height: 10,),
                MaterialButton(
                  onPressed: () async{
                    pro.addAddress();
                    pro.userAddresses.clear();
                    await pro.showUSerAddress();
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                  ),
                  minWidth: MediaQuery.of(context).size.width,
                  color: kThemeColor,
                  height: 50,
                  child: Text("Continue",style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
