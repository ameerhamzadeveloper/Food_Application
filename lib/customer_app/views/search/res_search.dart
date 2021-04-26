import 'package:flutter/material.dart';
import 'dart:io';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturants_providers.dart';
import 'package:food_delivery_app/customer_app/views/search/popular_widget.dart';
import 'package:food_delivery_app/customer_app/views/search/searched_resturants.dart';
import 'package:provider/provider.dart';
class ResutrantSearch extends StatefulWidget {
  @override
  _ResutrantSearchState createState() => _ResutrantSearchState();
}

class _ResutrantSearchState extends State<ResutrantSearch> {
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<NearResturantsProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)
                ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 0.75)
                    )
                  ],
                  color: Colors.white,
              ),
              height: 60,
              child: Row(
                children: [
                  IconButton(
                    color: kThemeColor,
                    onPressed: (){Navigator.pop(context);},
                    icon: Platform.isAndroid ? Icon(Icons.arrow_back) : Icon(Icons.arrow_back_ios),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        cursorColor: kThemeColor,
                        autofocus: true,
                        onChanged: (val){
                          pro.assignsearchVal(val);
                        },
                        onSubmitted: (val){
                          pro.addSearchedReas(context);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => SearchedResturants()
                          ));
                        },
                        decoration: InputDecoration(
                         fillColor: Colors.grey[300], filled: true,
                          border: InputBorder.none,
                          hintText: "Search restuarants,cusine and dishes",
                          suffixIcon: Icon(Icons.search),
                          focusColor: kThemeColor,
                          hoverColor: kThemeColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("Popular",textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PopularWidget(
                        name: "Burger",
                        onTap: (){},
                      ),
                      PopularWidget(
                        name: "Pizza",
                        onTap: (){},
                      ),
                      PopularWidget(
                        name: "Zinger",
                        onTap: (){},
                      ),
                      PopularWidget(
                        name: "Biryani",
                        onTap: (){},
                      ),
                      PopularWidget(
                        name: "Ice-Cream",
                        onTap: (){},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      PopularWidget(
                        name: "Tikka",
                        onTap: (){},
                      ),
                      PopularWidget(
                        name: "Zinger",
                        onTap: (){},
                      ),
                      PopularWidget(
                        name: "Shawarma",
                        onTap: (){},
                      ),
                      PopularWidget(
                        name: "Roll",
                        onTap: (){},
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

