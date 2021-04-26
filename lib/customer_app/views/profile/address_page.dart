import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/profile_provider.dart';
import 'package:food_delivery_app/customer_app/views/profile/add_address.dart';
import 'package:provider/provider.dart';
class AddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Address"),
      ),
      body: ListView.builder(
        itemCount: pro.userAddresses.length == null ? 0 : pro.userAddresses.length,
        itemBuilder: (ctx,i){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5.5,
              child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text("${pro.userAddresses[i].houseNo} ${pro.userAddresses[i].streetNo} ${pro.userAddresses[i].area} ${pro.userAddresses[i].city}"?? "Loading...."),
                  subtitle: Text("Home"),
                  trailing:Text("Home")
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: kThemeColor,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddAddress()));
        },
      ),
    );
  }
}
