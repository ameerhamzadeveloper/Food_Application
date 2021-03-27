import 'package:flutter/material.dart';
import 'package:food_delivery_app/customer_app/model/profile_provider.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturants_providers.dart';
import 'package:food_delivery_app/customer_app/views/cart_page/components/cart_item.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/views/profile/address_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  var paymentRad = 1;
  var cashRad = 0;
  @override
  void initState() {
    super.initState();
    final pro = Provider.of<NearResturantsProvider>(context,listen: false);
    pro.getUserIdEmail();
    pro.cartInitFunctions();
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NearResturantsProvider>(context);
    final pro = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        backgroundColor: Colors.white,
        title: Text("Order Details",style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("My Cart",style: TextStyle(fontSize: 18),),
              SizedBox(height: 10,),
              ListView.separated(
                separatorBuilder: (ctx,i){
                  return Divider();
                },
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.cartItems.length,
                itemBuilder: (ctx,i){
                  var list = provider.cartItems[i];
                  if(list.itemQty == '0'){
                    return Container();
                  }else{
                    return CartItem(
                      title: list.itemName,
                      subtitle: list.itemDescription,
                      image: "https://tripps.live/tripp_food/${list.itemImage}",
                      price: "${list.itemPrice}",
                      qty: list.itemQty,
                      onMinusTap: (){
                        provider.nagitiveSubtotal(int.parse(list.itemPrice));
                        print("tpeed -");
                        if(list.itemQty == '1'){
                          provider.removeItem(i);
                        }else{
                          provider.minusItem(i);
                        }
                      },
                      onPlusTap: (){
                        provider.positiveSubtotal(int.parse(list.itemPrice));
                        print("tpeed +");
                        provider.plusItem(i);
                      },
                    );
                  }
                },
              ),
              SizedBox(height: 20,),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Delivery Address",style: TextStyle(fontSize: 18),),
                    ListTile(
                      onTap: () async{
                        await pro.showUSerAddress();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AddressPage()));
                      },
                      leading: Icon(Icons.home_filled),
                      title: Text("${pro.deliveryHouse} ${pro.deliveryStreet} ${pro.deliveryArea} ${pro.deliveryCity}"?? "Loading...."),
                      subtitle: Text("Home"),
                      trailing: IconButton(onPressed: (){},icon: Icon(Icons.arrow_forward_ios),),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Payment Method",style: TextStyle(fontSize: 18),),
                    ListTile(
                      leading: Icon(Icons.credit_card_sharp),
                      title: Text("VISA Classic"),
                      subtitle: Text("7889 8787 787 7887"),
                      trailing: Radio(
                        value: paymentRad,
                        onChanged: (val){
                          setState(() {
                            cashRad = 0;
                            paymentRad = 1;
                          });
                        },
                        groupValue: 1,
                      ),
                    ),
                    provider.userFiveOrder >= 5 ?
                    ListTile(
                      leading: Icon(FontAwesome.money),
                      title: Text("Cash on delivery"),
                      trailing: Radio(
                        value: cashRad,
                        onChanged: (val){
                          setState(() {
                            cashRad = 1;
                            paymentRad = 0;
                          });
                        },
                        groupValue: 1,
                      ),
                    ):
                        Container()
                  ],
                ),
              ),
              TextField(
                maxLines: 4,
                onChanged: (val){
                  provider.setOtherInst(val);
                },
                decoration: InputDecoration(
                  labelText: 'Other Instructions',
                  border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order Info",style: TextStyle(fontSize: 20),),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Subtotal"),
                        Text("${provider.subtotal.toString()} SAR")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Delivery fee"),
                        Text("${provider.resturantInfos[0].deliPrice} SAR"),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total"),
                        Text("${provider.totalPrice} SAR",style: TextStyle(fontSize: 20),)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 50,
                color: kThemeColor,
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () async{
                  if(provider.cartOrderList.isEmpty && provider.cartItems.isEmpty){
                    print("Please add some items to your Cart");
                  }else{
                    provider.sendOrderToAPI(context);
                  }
                },
                child: Text("Place Order",
                  style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
