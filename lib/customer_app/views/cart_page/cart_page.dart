import 'package:flutter/material.dart';
import 'package:food_delivery_app/customer_app/model/navigation_bar_provider.dart';
import 'package:food_delivery_app/customer_app/model/profile_provider.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturant_list.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturants_providers.dart';
import 'package:food_delivery_app/customer_app/model/wallet_provider.dart';
import 'package:food_delivery_app/customer_app/navigation_bar/navigation_bar.dart';
import 'package:food_delivery_app/customer_app/views/cart_page/components/cart_item.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/views/cart_page/fined_boy_animated.dart';
import 'package:food_delivery_app/customer_app/views/profile/address_page.dart';
import 'package:food_delivery_app/customer_app/views/wallet/add_card.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:stripe_payment/stripe_payment.dart';

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
    StripePayment.setOptions(StripeOptions(
        publishableKey:
        "pk_test_51HmL50JgRTIAdsOfi2rmC7wsmSO0D8c5WhHtc7hF4ynY1RxHga5e1BmYC9jaKyAUqLX2kb334mtZSwy75fZZ42XG00Twg7quAx",
        merchantId: "Test",
        androidPayMode: 'test'));
    final pro = Provider.of<NearResturantsProvider>(context,listen: false);
    pro.getUserIdEmail();
    pro.cartInitFunctions();
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NearResturantsProvider>(context);
    final pro = Provider.of<ProfileProvider>(context);
    final wpro = Provider.of<WalletProvider>(context);
    final navPro = Provider.of<NavigationProvider>(context);
    final markeetPro = Provider.of<ResturantList>(context);
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
                    wpro.isCardAdded ?
                    ListTile(
                      leading: Icon(Icons.credit_card_sharp),
                      title: Text(wpro.cardHolderName),
                      subtitle: Text(wpro.cardNumber),
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
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          color: Colors.white,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => AddCard()
                            ));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              Text("Add Card"),
                            ],
                          ),
                        ),
                      ],
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
                    showToast("Please add some items to your Cart", duration: Toast.LENGTH_LONG);
                  }else if(wpro.isCardAdded == true || provider.userFiveOrder >= 5){
                    if(provider.isCurrentOrder == true){
                      showToast("You Have Already Active Order", duration: Toast.LENGTH_LONG);
                      navPro.index = 1;
                      Future.delayed(Duration(seconds: 1),(){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => NavigationBar()
                        ));
                      });
                    }else{
                      markeetPro.clearMarkeets();
                      navPro.index = 1;
                      if(provider.userFiveOrder >= 5){
                        showModalBottomSheet(
                            context: context,
                            builder: (ctx,){
                              return FindBoyAnimated();
                            }
                        );
                        provider.sendOrderToAPI(context,'0');
                      }else{
                        showModalBottomSheet(
                          context: context,
                          builder: (ctx,){
                            return FindBoyAnimated();
                          }
                        );
                        final CreditCard testCard = CreditCard(
                            number: wpro.cardNumber,
                            expMonth: int.parse(wpro.expiryDate.substring(0, 2)),
                            expYear: int.parse(wpro.expiryDate.substring(3, 5)));
                        StripePayment.createTokenWithCard(testCard).then((token) async{
                          var prov = Provider.of<NearResturantsProvider>(context, listen: false);
                          await prov.payWithCard(token.tokenId,context);
                          print(token.tokenId);
                        });

                      }
                    }
                  }else{
                    showToast("Please Add Your Credit Card", duration: Toast.LENGTH_LONG);
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
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: 3,textColor: Colors.red,backgroundColor: Colors.grey[200],);
  }
}
