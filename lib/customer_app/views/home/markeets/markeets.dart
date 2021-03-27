import 'package:flutter/material.dart';

import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/resturant/markeets_providers.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturant_list.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturants_providers.dart';
import 'package:food_delivery_app/customer_app/views/home/markeets/markeet_info.dart';
import 'package:provider/provider.dart';

class Markeets extends StatefulWidget {
  @override
  _MarkeetsState createState() => _MarkeetsState();
}

class _MarkeetsState extends State<Markeets> {

  @override
  void initState() {
    super.initState();
    final pro = Provider.of<NearResturantsProvider>(context,listen: false);
    pro.getUserIdEmail();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<NearResturantsProvider>(context);
    final pro = Provider.of<ResturantList>(context);
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: IconButton(
            onPressed: (){
              pro.clearMarkeets();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          pinned: true,
          floating: false,
          expandedHeight: 80,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              kGetTranslated(context, 'markeets')
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 80,
            decoration: BoxDecoration(color: kThemeColor),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left:8.0,right: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: kGetTranslated(context, 'search_markeets'),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: Icon(Icons.search),
                        focusColor: kThemeColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        pro.markeets.length == 0 ? SliverList(delegate: SliverChildListDelegate(
          [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error,color: Colors.red,),
                SizedBox(width: 5,),
                Text("Tripp is not providing service in your area",style: TextStyle(color: Colors.red,),),
              ],
            )
          ]
        )) :SliverList(delegate: SliverChildListDelegate(
        List.generate(pro.markeets.length, (i){
          var list = pro.markeets[i];
          if(pro.markeets.length == 0){
            return Center(child: Text("No Nearby Markeets"),);
          }else{
            return InkWell(
              onTap: ()async{
                prov.resturantId = pro.markeets[i].id;
                await prov.showShopInfo();
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MarkeetstsDetails()
                ));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 160,
                                  width: 150,
                                  child: Image.network(
                                    "https://tripps.live/tripp_food/${list.markeetSelfie}",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${list.bName}",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("${list.description}"),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "SR ${list.deliFee} Delivery fee  SR ${list.minimum} minimum",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
    })
    )
      )
      ],
    )
    );
  }
}
