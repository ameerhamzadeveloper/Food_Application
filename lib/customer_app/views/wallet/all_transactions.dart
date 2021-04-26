import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/profile_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class AllTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profPro = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kThemeColor,
        title: Text(
          kGetTranslated(context, 'recent_transactions')
        ,style: TextStyle(color: Colors.white),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: profPro.myTransaction == null ? 0 : profPro.myTransaction.length,
            itemBuilder: (ctx,i){
              var date = profPro.myTransaction[i].date;
              var finalDate = DateFormat('yyyy-MM-dd').format(date);
              return  Card(
                elevation: 5.0,
                child: Center(
                  child: ListTile(
                    title: Text("SAR ${profPro.myTransaction[i].totalPrice}"),
                    subtitle: Text(profPro.myTransaction[i].resturant),
                    trailing: Text(finalDate),
                  ),
                ),
              );
            },
          ),
        )
      ),
    );
  }
}
