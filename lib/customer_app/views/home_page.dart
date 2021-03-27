import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/components/welcome_page.dart';
import 'package:food_delivery_app/customer_app/model/profile_provider.dart';
import 'package:food_delivery_app/customer_app/model/resturant/markeets_providers.dart';
import 'package:food_delivery_app/customer_app/views/home/map_screen.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/routes/routes_names.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturants_providers.dart';


class HOmePage extends StatefulWidget {
  @override
  _HOmePageState createState() => _HOmePageState();
}

class _HOmePageState extends State<HOmePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(
          kGetTranslated(context, 'home_page')
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            WelcomePage(
              image: "images/resturant.jpg",
              buttonTitle: "${kGetTranslated(context, 'find_resturant')}",
              ontap: () async{
                final pro = Provider.of<NearResturantsProvider>(context,listen: false);
                Navigator.pushNamed(context, resturants);
                await pro.fetchNearbyResturants(context);
                await pro.fetchAllResturants(context);
              },
            ),
            WelcomePage(
              image: "images/markeet.jpg",
              buttonTitle: "${kGetTranslated(context, 'find_markeets')}",
              ontap: () async{
                final pro = Provider.of<MarkeetsProviders>(context,listen: false);
                // // pro.fetchMyOrders();
                 await pro.fetchNearbyMarkeets(context);
                Navigator.of(context).pushNamed('markeets');
              },
            ),
          ],
        ),
      ),
    );
  }
}

