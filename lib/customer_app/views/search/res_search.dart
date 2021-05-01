import 'package:flutter/material.dart';
import 'dart:io';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturants_providers.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturant_list.dart';
import 'package:food_delivery_app/customer_app/views/search/popular_widget.dart';
import 'package:food_delivery_app/customer_app/views/search/searched_resturants.dart';
import 'package:provider/provider.dart';

class ResutrantSearch extends StatefulWidget {
  @override
  _ResutrantSearchState createState() => _ResutrantSearchState();
}

class _ResutrantSearchState extends State<ResutrantSearch> {
  String searchItem = "";
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<NearResturantsProvider>(context);
    final pro2 = Provider.of<ResturantList>(context, listen: false);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 0.75))
                ],
                color: Colors.white,
              ),
              height: 60,
              child: Row(
                children: [
                  IconButton(
                    color: kThemeColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Platform.isAndroid
                        ? Icon(Icons.arrow_back)
                        : Icon(Icons.arrow_back_ios),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        cursorColor: kThemeColor,
                        autofocus: true,
                        onSaved: (val){
                           setState(() {
                            pro.assignsearchVal(val);
                            searchItem = val;
                          });
                        },
                        onChanged: (val) {
                          setState(() {
                            pro.assignsearchVal(val);
                            searchItem = val;
                          });
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.grey[300],
                          filled: true,
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
                        Text(
                          "Popular",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PopularWidget(
                        name: "Burger",
                        onTap: () {},
                      ),
                      PopularWidget(
                        name: "Pizza",
                        onTap: () {},
                      ),
                      PopularWidget(
                        name: "Zinger",
                        onTap: () {},
                      ),
                      PopularWidget(
                        name: "Biryani",
                        onTap: () {},
                      ),
                      PopularWidget(
                        name: "Ice-Cream",
                        onTap: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      PopularWidget(
                        name: "Tikka",
                        onTap: () {},
                      ),
                      PopularWidget(
                        name: "Zinger",
                        onTap: () {},
                      ),
                      PopularWidget(
                        name: "Shawarma",
                        onTap: () {},
                      ),
                      PopularWidget(
                        name: "Roll",
                        onTap: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              children: pro2.resturantList
                  .where((element) => element.bName
                      .toLowerCase()
                      .contains(searchItem.toLowerCase()))
                  .map((e) {
                return Container(
                    // height: screen ? width * 0.3 : height * 0.3,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                        onTap: () {
                           pro.addSearchedReas(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchedResturants(searchResturant:e)));
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.grey[200],
                                width: width,
                                child: Text(e.bName,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        )));
                // : SizedBox();
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
