import 'package:flutter/material.dart';
import 'package:food_delivery_app/common_clip_paths/signup_uper_clip.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/profile_provider.dart';
import 'package:food_delivery_app/delivery_boy_app/models/dash_order.dart';
import 'package:food_delivery_app/delivery_boy_app/models/deli_profile_provider.dart';
import 'package:food_delivery_app/delivery_boy_app/views/orders/current_order.dart';
import 'package:food_delivery_app/delivery_boy_app/views/orders/recent_order.dart';
import 'package:food_delivery_app/delivery_boy_app/views/orders/view_order.dart';
import 'package:food_delivery_app/delivery_boy_app/views/wallet/deli_wallet.dart';
import 'package:food_delivery_app/resturant_app/model/resturant_profile_provider.dart';
import 'package:food_delivery_app/resturant_app/views/home/components/circular_indicator.dart';
import 'package:food_delivery_app/routes/routes_names.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/delivery_boy_app/models/deli_map_model.dart';
import 'package:food_delivery_app/models/sign_up_model.dart';

final topCardsubhead = TextStyle(color: Colors.grey[700], fontSize: 20);
final topCardHead = TextStyle(color: Colors.black, fontSize: 25);

class DeliveryBoyHomePage extends StatefulWidget {
  @override
  _DeliveryBoyHomePageState createState() => _DeliveryBoyHomePageState();
}

class _DeliveryBoyHomePageState extends State<DeliveryBoyHomePage> {


  void getLatLong(BuildContext context) async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final provider = Provider.of<DeliMapModel>(context, listen: false);
    provider.lat = position.latitude;
    provider.lon = position.longitude;
    final pro = Provider.of<DashOrders>(context,listen: false);
    final profPro = Provider.of<DeliProfileProvider>(context,listen: false);
    await profPro.getIdEmail();
    await pro.getIdEmail();
    provider.getIdEmail();
    profPro.fetchBoyProfile();
    await pro.fetchCancelOrders();
    await pro.fetchEaringTotalOrder();
    await pro.fetchRating();
    await pro.showRecentOrders();
    print(provider.getlat);
    print(provider.getlon);
  }

  @override
  void initState() {
    super.initState();
    getLatLong(context);
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeliMapModel>(context, listen: false);
    final signPro = Provider.of<SignUpModel>(context);
    final dash = Provider.of<DashOrders>(context);
    final proPro = Provider.of<DeliProfileProvider>(context);
    final textThem = Theme.of(context).textTheme;
    final providere = Provider.of<ProfileProvider>(context);
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      ClipOval(
                        child:
                        proPro.profileImage ==
                            null
                            ?
                        Image.asset(
                          "images/user.png",
                          height: 90,
                          width: 90,
                        )
                            : Image.network(
                          'https://tripps.live/tripp_food/${proPro.profileImage}',
                          height: 80,
                          width: 80,
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "${proPro.profileName ?? "Loading.."}",
                          style: TextStyle(fontSize: 20),
                        ),
                        proPro.avaluateRating(),
                        Text("Rating ${proPro.rating ?? "0"}.0" ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              title: Text("Home"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => CurrentOrderBoy()
                ));
              },
              title: Text("Current Orders"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DeliRecentOrders()
                ));
              },
              title: Text("Orders History"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => DeliWallet()
                ));
              },
              title: Text("Wallet"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              onTap: () {

              },
              title: Text("How it works"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              onTap: () {

              },
              title: Text("Contact Us"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            FlatButton(
              onPressed: () {
                providere.logout(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.exit_to_app),
                  Text("Log Out"),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: textThem.headline2,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: MaterialButton(
                onPressed: () {
                  print(signPro.storedEmail);
                  print(signPro.id);
                  provider.getIdEmail();
                  provider.putDeliBoyOnline(context,1);
                  Navigator.pushNamed(context, deliMapScreen);
                },
                child: Text("Start",style: TextStyle(color: Colors.black),),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 5.0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              "Weekly Report",
                              style: TextStyle(color: Colors.green),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Earinings",
                                style: topCardsubhead,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "SAR ${dash.earning ?? "0"}",
                                style: topCardHead,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Orders",
                                style: topCardsubhead,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                dash.totalOrders ?? "0",
                                style: topCardHead,
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Rating",
                                style: topCardsubhead,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "${dash.rating ?? "0"}.0",
                                style: topCardHead,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Cancel",
                                style: topCardsubhead,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                dash.cancelOrders ?? "0",
                                style: topCardHead,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircularIndicator(
                      color: Colors.green,
                      percent: 0.9,
                      prcntiner: "90%",
                      title: "Earnings",
                    ),
                    CircularIndicator(
                      color: Colors.orange,
                      percent: 0.8,
                      prcntiner: "30%",
                      title: "Orders",
                    ),
                    CircularIndicator(
                      color: Colors.green,
                      percent: 1.0,
                      prcntiner: "100%",
                      title: "Rating",
                    ),
                    CircularIndicator(
                      color: Colors.red,
                      percent: 0.3,
                      prcntiner: "30%",
                      title: "Cancel",
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Orders",
                    style: textThem.bodyText1,
                  ),
                  FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => DeliRecentOrders()
                      ));
                    },
                    child: Text("See all"),
                  )
                ],
              ),
              dash.orders == null ? Text("No Recent Order") : ListView.builder(
                shrinkWrap: true,
                itemCount: dash.orders == null ? 0 : dash.orders.length,
                itemBuilder: (ctx,i){
                  var ord = dash.orders[i];
                  var date = ord.date;
                  var finalDate = DateFormat('yyyy-MM-dd').format(date);
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => DeliViewOrder(
                            totalPrice: ord.totalPrice,
                            orderStatus: ord.orderStatus,
                            orderId: ord.orderId,
                            customerAddress: ord.customerAddress,
                            customerName: ord.uName,
                            date: finalDate,
                            deliveryPrice: ord.deliveryFee,
                            orders: dash.orders,
                            userImage: ord.userImg,
                            itemIndex: i,
                            resturantName: ord.bName,
                          )
                      ));
                    },
                    child: Card(
                      child: ListTile(
                        leading: ClipOval(
                          child: Image.network(
                            "https://tripps.live/tripp_food/${dash.orders[i].userImg}",
                            fit: BoxFit.fill,
                            height: 80,
                            width: 60,
                          ),
                        ),
                        title: Text(dash.orders[i].uName),
                        subtitle: Text(dash.orders[i].customerAddress),
                        trailing: Text(finalDate ?? "Loading.."),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
