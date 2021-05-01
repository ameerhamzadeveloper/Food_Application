import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
class CartItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String image;
  final String qty;
  final Function onPlusTap;
  final Function onMinusTap;
  CartItem({this.price,this.title,this.image,this.subtitle,this.qty,this.onMinusTap,this.onPlusTap});
  @override
  Widget build(BuildContext context) {
    return card();
  }
  Widget list (){
    return ListTile(
      title: Text(title),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: onMinusTap,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)
              ),
              elevation: 3.0,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Icon(AntDesign.minus,size: 15,),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Text("${qty}x"),
          SizedBox(width: 10,),
          InkWell(
           onTap: onPlusTap,
            child: Icon(AntDesign.plus,size: 15)
          ),
        ],
      ),
      trailing: Text("$price SAR",style: TextStyle(color: Colors.grey),),
    );
  }
  Widget card(){
    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                child: Image.network(image,height: 60,width: 80,fit: BoxFit.fill,),
              ),
            ],
          ),
          SizedBox(width: 20,),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,style: TextStyle(fontSize: 15,),),
                    Text(subtitle,style: TextStyle(fontSize: 13),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: onMinusTap,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)
                            ),
                            elevation: 3.0,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Icon(AntDesign.minus,size: 15,),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text("${qty}x"),
                        SizedBox(width: 10,),
                        InkWell(
                          onTap: onPlusTap,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            elevation: 3.0,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Icon(AntDesign.plus,size: 15),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$price SAR",style: TextStyle(color: Colors.grey),)
            ],
          ),
        ],
      ),
    );
  }
}
