import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturants_providers.dart';
import 'package:food_delivery_app/customer_app/views/search/res_search.dart';
import 'package:food_delivery_app/customer_app/views/home/resturants/components/resturant_card.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturants_model.dart';
import 'package:food_delivery_app/routes/routes_names.dart';

class SearchedResturants extends StatefulWidget {
  final ResturantsModel searchResturant;

  const SearchedResturants({Key key, this.searchResturant}) : super(key: key);
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
          onPressed: () {
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResutrantSearch()));
                        },
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                kGetTranslated(context, 'search_resturants'),
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                              Icon(
                                Icons.search,
                                color: kThemeColor,
                              )
                            ],
                          ),
                        )),
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
            InkWell(
              onTap: () {
                pro.resturantId = widget.searchResturant.id;
                pro.showResturantInfo();
                pro.fetchMenuCards(context);
                print(widget.searchResturant.id);
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.pushNamed(context, resturantDetailsPage);
                });
              },
              child: ResturantCard(
                title: widget.searchResturant.bName ?? "",
                image:
                    "https://tripps.live/tripp_food/${widget.searchResturant.resturantSelfie}",
                deleveryFee: widget.searchResturant.minimum ?? 0,
                minRate: widget.searchResturant.deliFee ?? "0",
                subtitle: widget.searchResturant.description ?? "",
                rating: widget.searchResturant.rating.toString(),
                ratingLength: widget.searchResturant.ratingLength.toString(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
