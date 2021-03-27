import 'package:flutter/material.dart';

import 'package:food_delivery_app/constants.dart';

class AllResturantCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String minRate;
  final String deleveryFee;
  final String rating;
  final String ratingLength;

  AllResturantCard(
      {this.deleveryFee, this.image, this.minRate, this.subtitle, this.title,this.rating,this.ratingLength});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 120,
              width: 240,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        image,
                      ),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: kAllResturantTitleStyle,textAlign: TextAlign.start,),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.green,
                    ),
                    Text("$rating ($ratingLength)")
                  ],
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text("SAR $minRate minimum ", style: kAllLastResturantTextStyle),
                Text(
                  ": SAR $deleveryFee Delivery fee",
                  style: kAllLastResturantTextStyle,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
