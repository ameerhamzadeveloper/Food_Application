import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/resturant_app/views/home/menu/add_more_menu_fields.dart';
// import 'package:food_delivery_app/resturant_app/views/home/menu/edit_menu_items.dart';
import 'package:food_delivery_app/resturant_app/model/menu_card_item_model.dart';

class OfferCard extends StatelessWidget {
  final String title;
  final String price;
  final Function addItems;
  final Function deletCard;
  final Function editCard;
  final List<MenuCardItemsModel> children;
  OfferCard({this.children, this.price, this.title,this.addItems,this.deletCard,this.editCard});
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
                IconButton(
                  onPressed: editCard,
                  icon: Icon(Icons.edit),
                )
              ],
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: children != null && children.length > 0 ? children.length : 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _buildItem(children[index]);
              },
            ),
            SizedBox(
              height: 30,
            ),
            Text(price),
            Row(
              children: [
                Expanded(
                  child: OutlineButton(
                    highlightedBorderColor: kThemeColor,
                    onPressed: addItems,
                    child: Text("Add More"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: deletCard,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildItem(MenuCardItemsModel item) {
    return ListTile(
      leading: Image.network("https://tripps.live/tripp_food/${item.itemImage}"),
      title: Text(item.itemName),
      subtitle: Text(item.itemDescription),
    );
  }
}