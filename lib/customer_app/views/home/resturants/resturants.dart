import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/views/home/resturants/components/all_resturant_Card.dart';
import 'package:food_delivery_app/customer_app/views/search/res_search.dart';
import 'components/resturant_card.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturants_providers.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturant_list.dart';
import 'package:food_delivery_app/routes/routes_names.dart';


class Resturants extends StatefulWidget {
  @override
  _ResturantsState createState() => _ResturantsState();
}

class _ResturantsState extends State<Resturants> {

  @override
  void initState() {
    super.initState();
    final pro = Provider.of<NearResturantsProvider>(context,listen: false);
    pro.getUserIdEmail();
  }
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ResturantList>(context);
    final pr = Provider.of<NearResturantsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            prov.clearAllList();
            prov.clearAllResturants();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 36 + 20.0,
                    ),
                    margin: EdgeInsets.only(bottom: 10 * 1.5),
                    height: MediaQuery.of(context).size.height / 6,
                    decoration: BoxDecoration(
                        color: kThemeColor,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          kGetTranslated(context, 'resturants'),
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Icon(
                          Icons.food_bank,
                          color: Colors.white,
                          size: 50,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 54,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 50,
                                color: Colors.black.withOpacity(0.30))
                          ]),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ResutrantSearch()
                          ));
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(kGetTranslated(context, 'search_resturants'),style: TextStyle(color: Colors.grey[800]),),
                                Icon(Icons.search,color: kThemeColor,)
                              ],
                            ),
                          )
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("All Restaurants"),
                    ],
                  ),
                  SizedBox(height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: prov.allResturants.length,
                    itemBuilder: (ctx,i){
                      var list = prov.allResturants[i];
                      if(prov.allResturants.isEmpty){
                        return Center(child: CircularProgressIndicator(),);
                      }else{
                        return InkWell(
                          onTap: () async{
                            pr.resturantId = prov.allResturants[i].id;
                            await pr.showResturantInfo();
                            print(prov.allResturants[i].id);
                            Navigator.pushNamed(context, resturantDetailsPage);
                          },
                          child: AllResturantCard(
                            title: prov.allResturants[i].bName,
                            image: "https://tripps.live/tripp_food/${prov.allResturants[i].resturantSelfie}",
                            deleveryFee: prov.allResturants[i].minimum,
                            minRate: prov.allResturants[i].deliFee,
                            subtitle: prov.allResturants[i].description,
                            rating: prov.allResturants[i].rating.toString(),
                            ratingLength: prov.allResturants[i].ratingLength.toString(),
                          ),
                        );
                      }
                    },
                  ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [Text(kGetTranslated(context, 'nearby_resturants'))],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  prov.resturantList.length == 0 ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error,color: Colors.red,),
                      SizedBox(width: 5,),
                      Text("Tripp is not providing service in your area",style: TextStyle(color: Colors.red,),),
                    ],
                  ):
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: prov.resturantList.length,
                    itemBuilder: (ctx,i){
                      if(prov.resturantList.isEmpty){
                        return Center(child: CircularProgressIndicator(),);
                      }else{
                        return InkWell(
                          onTap: (){
                            pr.resturantId = prov.resturantList[i].id;
                            pr.showResturantInfo();
                            pr.fetchMenuCards(context);
                            print(prov.resturantList[i].id);
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.pushNamed(context, resturantDetailsPage);
                            });
                          },
                          child: ResturantCard(
                            title: prov.resturantList[i].bName ?? "",
                            image: "https://tripps.live/tripp_food/${prov.resturantList[i].resturantSelfie}",
                            deleveryFee: prov.resturantList[i].minimum ?? 0,
                            minRate: prov.resturantList[i].deliFee ?? "0",
                            subtitle: prov.resturantList[i].description ?? "",
                            rating: prov.resturantList[i].rating.toString(),
                            ratingLength: prov.resturantList[i].ratingLength.toString(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
