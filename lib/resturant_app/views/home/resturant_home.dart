import 'package:flutter/material.dart';
import 'package:food_delivery_app/resturant_app/model/orders_porvider.dart';
import 'package:food_delivery_app/resturant_app/views/home/components/circular_indicator.dart';
import 'package:food_delivery_app/resturant_app/views/home/menu/menu_page.dart';
import 'package:food_delivery_app/resturant_app/views/orders/current_orders.dart';
import 'package:food_delivery_app/resturant_app/views/orders/view_order.dart';
import 'package:food_delivery_app/resturant_app/views/recent_orders.dart';
import 'package:food_delivery_app/resturant_app/views/wallet/wallet.dart';
import 'package:food_delivery_app/resturant_app/views/contact_us.dart';
import 'package:food_delivery_app/resturant_app/views/signup/personal_information.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/resturant_app/model/resturant_profile_provider.dart';
import 'package:food_delivery_app/resturant_app/model/resturant_menu_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final topCardsubhead = TextStyle(color: Colors.grey[700], fontSize: 20);
final topCardHead = TextStyle(color: Colors.black, fontSize: 25);

class ResturantHomePage extends StatefulWidget {
  @override
  _ResturantHomePageState createState() => _ResturantHomePageState();
}

class _ResturantHomePageState extends State<ResturantHomePage> {

  void init()async{
    final prov = Provider.of<ResturantProfileProvider>(context, listen: false);
    var pro = Provider.of<MenuProvider>(context,listen: false);
    await pro.getIdEmail();
    await prov.getIdEmail();
    final ordProvdier = Provider.of<OrdersProvider>(context,listen: false);
    final mPro = Provider.of<MenuProvider>(context,listen: false);
    mPro.getIdEmail();
    await ordProvdier.getIdEmail();
    await prov.fetchResturantProfile();
    await ordProvdier.fetchDashboard(context);
    await ordProvdier.showORders(context);
    await ordProvdier.fetchDashboardCancel(context);
    await ordProvdier.fetchDashboardRating(context);
    print(prov.userid);

  }
  @override
  void initState() {
    super.initState();
   init();
  }

  @override
  Widget build(BuildContext context) {
    final textThem = Theme.of(context).textTheme;
    final provider = Provider.of<ResturantProfileProvider>(context);
    final ordProvdier = Provider.of<OrdersProvider>(context);
    final menuProvider = Provider.of<MenuProvider>(context);
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
                        child: provider.profileImage == null
                            ? Image.asset(
                                "images/user.png",
                                height: 90,
                                width: 90,
                              )
                            : Image.network(
                                'https://tripps.live/tripp_food/${provider.profileImage}',
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
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          provider.profileName ?? "Loading...",
                          style: TextStyle(fontSize: 20),
                        ),
                        provider.avaluateRating(),
                        Text("Rating ${provider.rating}.0")
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      // IconButton(
                      //   onPressed: () async {
                      //     SharedPreferences preferences = await SharedPreferences.getInstance();
                      //     preferences.setString('email', 'thisisresturant@gmail.com');
                      //     preferences.setString('id', '42');
                      //   },
                      //   icon: Icon(
                      //     Icons.settings,
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            ListTile(
              onTap: () {

                ordProvdier.fetchCurrentOrders();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => CurrentOrders()
                ));
              },
              title: Text("Current Orders"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecentOrders(),
                  ),
                );
              },
              title: Text("Orders History"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              onTap: () {
                ordProvdier.fetchDashboard(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ResturantWallet(),
                //   ),
                // );
              },
              title: Text("Wallet"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResturantPersonalInfo(),
                  ),
                );
              },
              title: Text("How it works"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResturantContactUs(),
                  ),
                );
              },
              title: Text("Contact Us"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            FlatButton(
              onPressed: () {},
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
          IconButton(
            onPressed: () async {
              menuProvider.showCardItems(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuPage(),
                ),
              );
            },
            icon: Icon(Icons.my_library_books_outlined),
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
                                "SAR ${ordProvdier.earnings ?? "0"} ",
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
                                ordProvdier.totalORder ?? "0",
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
                                "${ordProvdier.rating ?? "0"}.0",
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
                                "${ordProvdier.cancelOrders ?? "0"}",
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
                      // ordProvdier.earningPercentage ??
                      percent:  0.0,
                      prcntiner: "${ordProvdier.earningPercentage ?? "0"}%",
                      title: "Earnings",
                    ),
                    CircularIndicator(
                      color: Colors.orange,
                      percent: 0.0,
                      prcntiner: "${ordProvdier.earningPercentage ?? "0"}%",
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecentOrders()));
                    },
                    child: Text("See all"),
                  )
                ],
              ),
              ordProvdier.orders == null ?
              Center(child: Text("No Recent Orders"),) :
              ListView.builder(
                shrinkWrap: true,
                itemCount: ordProvdier.orders == null ? 0 : ordProvdier.orders.length > 4 ? 4 : ordProvdier.orders.length,
                itemBuilder: (ctx,i){
                  var ord = ordProvdier.orders[i];
                  var date = ord.date;
                  var finalDate = DateFormat('yyyy-MM-dd').format(date);
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ViewOrder(
                          totalPrice: ord.totalPrice,
                          orderStatus: ord.orderStatus,
                          orderId: ord.orderId,
                          customerAddress: ord.customerAddress,
                          customerName: ord.uName,
                          date: finalDate,
                          deliveryPrice: ord.deliveryFee,
                          orders: ordProvdier.orders,
                          userImage: ord.userImg,
                          itemIndex: i,
                        )
                      ));
                    },
                    child: Card(
                      child: ListTile(
                        leading: ClipOval(
                          child: Image.network(
                            "https://tripps.live/tripp_food/${ord.userImg}",
                            fit: BoxFit.fill,
                            height: 80,
                            width: 60,
                          ),
                        ),
                        title: Text(ord.uName ?? "Loading"),
                        subtitle: Text(ord.customerAddress ?? "Loading"),
                        trailing: Text(finalDate),
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
