import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturant_info.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturants_providers.dart';
import 'package:provider/provider.dart';
class ItemBottomSheet extends StatefulWidget {
  final Item l;
  final NearResturantsProvider pr;
  final List<ResturantInfo> list;
  ItemBottomSheet({this.l,this.pr,this.list});
  @override
  _ItemBottomSheetState createState() => _ItemBottomSheetState();
}

class _ItemBottomSheetState extends State<ItemBottomSheet> {

  int itemQty = 1;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: MediaQuery.of(context).size.height/1.65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(20),
              ),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "https://tripps.live/tripp_food/${widget.l.itmeImg}"
                  )
              ),
              // color: Colors.white,
            ),
            height: height/3,
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(height: height/20,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.l.itemName,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                    Text("${widget.l.itemPrice} SAR",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(height: 10,),
                Text(widget.l.itemDescription),
                SizedBox(height: 15,),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        decreaseItemQty();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(100)
                        // ),
                        // elevation: 3.0,
                        minRadius: 15,
                        maxRadius: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(AntDesign.minus,size: 20,),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text("$itemQty"),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: (){
                        print("called");
                        // setState(() {
                        //   print(itemQty.toString());
                        //   itemQty++;
                        // });
                        increaseItemQty();
                      },
                      child: CircleAvatar(
                        backgroundColor: kThemeColor,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(100),
                        // ),
                        minRadius: 15,
                        maxRadius: 20,
                        // elevation: 3.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(AntDesign.plus,size: 20,color: Colors.white,),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        height: 40,
                        color: kThemeColor,
                        onPressed: (){

                          widget.pr.addToCart(widget.l.itemName, widget.l.itemDescription, widget.l.itemPrice.toString(), widget.l.itmeImg, widget.list[0].resturantId,widget.l.itemId,itemQty: itemQty.toString());
                          print("cartORderLsit ${widget.pr.cartOrderList.length}");
                          print("cartItems $itemQty");
                          makezerotoItemQty();
                          Navigator.pop(context);

                        },
                        child: Text("Add To Cart",style: TextStyle(color: Colors.white),),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  void increaseItemQty(){
   setState(() {
     itemQty++;
   });
   print(itemQty);
  }
  void decreaseItemQty(){
    setState(() {
      itemQty--;
    });
  }
  void makezerotoItemQty(){
    setState(() {
      itemQty = 1;
    });
  }
}
