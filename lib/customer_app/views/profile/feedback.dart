import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("FeedBack"),),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("How was your overall experience?",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                SizedBox(height: 10,),
                Text("It will help us to serve you better"),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmoothStarRating(
                      size: 40,
                      color: kThemeColor,
                      borderColor: kThemeColor,
                      rating: 0,
                      onRated: (val){
                        pro.setStars(val);
                      },
                    ),
                    SizedBox(width: 10,),
                    Text("${pro.stars}",style: TextStyle(fontSize: 20),)
                  ],
                ),
                SizedBox(height: 10,),
                Text("It's Excellent",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text("Your Message (optional)",style: TextStyle(fontSize: 15),),
                SizedBox(height: 10,),
                TextField(
                  onChanged: (val){
                    pro.setMessage(val);
                  },
                  maxLines: 10,
                  decoration: InputDecoration(
                      hintText: "Please specify in detail",
                      border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 10,),
                MaterialButton(
                  onPressed: (){
                    pro.postAppFeedBack();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: kThemeColor)
                  ),
                  minWidth: MediaQuery.of(context).size.width,
                  color: kThemeColor,
                  height: 50,
                  child: Text("Submit",style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}