import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturants_providers.dart';
import 'package:food_delivery_app/resturant_app/model/menu_card_item_model.dart';
import 'package:provider/provider.dart';

class MenuCardComponent extends StatelessWidget {
  final String title;
  final String price;
  final Function addItems;
  final List<MenuCardItemsModel> children;
  MenuCardComponent({this.children, this.price, this.title,this.addItems});
  @override
  Widget build(BuildContext context) {

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: children != null && children.length > 0 ? children.length : 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _buildItem(children[index],context);
              },
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  _buildItem(MenuCardItemsModel item,BuildContext context) {
    final pr = Provider.of<NearResturantsProvider>(context);
    return InkWell(
      onTap: (){
        print(item.itemName);
        pr.addToCart(item.itemName, item.itemDescription, item.itemPrice, item.itemImage,item.resturantId,item.itemId);
      },
      child: ListTile(
        leading: Container(
          height: 80,
            width: 80,
            child: Card(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network("https://tripps.live/tripp_food/${item.itemImage}",fit: BoxFit.fill,),
            ))),
        title: Text(item.itemName),
        subtitle: Text(item.itemDescription),
        trailing: Text("${item.itemPrice} SAR"),
      ),
    );
  }
}