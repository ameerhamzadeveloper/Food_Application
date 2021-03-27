import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturants_providers.dart';
import 'package:food_delivery_app/customer_app/views/home/resturants/components/resturant_card.dart';
import 'package:food_delivery_app/customer_app/views/search/res_search.dart';
import 'package:provider/provider.dart';
class SearchedResturants extends StatefulWidget {
  @override
  _SearchedResturantsState createState() => _SearchedResturantsState();
}

class _SearchedResturantsState extends State<SearchedResturants> {
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<NearResturantsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text("Search Result"),
                ],
              ),
            ),
            // ListView.builder(
            //   itemCount: pro.searchedRes != null ? pro.searchedRes.length : 0,
            //   itemBuilder: (ctx,i){
            //     return ResturantCard(
            //       title: pro.searchedRes[i].bName,
            //       image: "https://tripps.live/tripp_food/${pro.searchedRes[i].resutrantSelfie}",
            //       subtitle: pro.searchedRes[i].
            //     );
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
