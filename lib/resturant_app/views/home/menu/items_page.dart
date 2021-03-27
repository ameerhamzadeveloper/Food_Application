import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/resturant_app/model/menu_list.dart';
import 'package:food_delivery_app/resturant_app/model/resturant_menu_provider.dart';
import 'package:food_delivery_app/resturant_app/views/home/menu/components/offer.dart';
import 'package:food_delivery_app/constants.dart';

class ItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<MenuLists>(context);
    final pro = Provider.of<MenuProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            prov.clearAllList();
            pro.fetchMenuCards(context);
            prov.clearAllItemList();
            Future.delayed(Duration(seconds: 1), () {
              Navigator.pop(context);
            });

          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Card Items"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: prov.itemList.length,
              itemBuilder: (ctx,i){
                return Offer(
                  title: prov.itemList[i].itemName,
                  image: prov.itemList[i].itemImage,
                  discription: prov.itemList[i].itemDescription,
                  delete: (){},
                  edit: (){},
                  itemPrice: "${prov.itemList[i].itemPrice} SAR",
                );
              },
            ),
            MaterialButton(
              color: kThemeColor,
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                        child:Container(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Container(),
                        )
                    )
                );
              },
              child: Text(
                "Add",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
