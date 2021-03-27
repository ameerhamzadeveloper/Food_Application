import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/resturant_app/model/resturant_menu_provider.dart';
import 'package:food_delivery_app/resturant_app/views/home/menu/add_more_menu_fields.dart';
import 'package:food_delivery_app/resturant_app/views/home/menu/components/offer_card.dart';
import 'package:food_delivery_app/resturant_app/views/home/menu/components/add_card_bottom_sheet.dart';
import 'package:food_delivery_app/resturant_app/model/menu_list.dart';
import 'package:food_delivery_app/resturant_app/views/home/menu/edit_menu_cards.dart';
import 'package:food_delivery_app/resturant_app/views/home/menu/edit_menu_item.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MenuLists>(context);
    final pro = Provider.of<MenuProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            provider.clearAllList();
            Navigator.pop(context);
          },
        ),
        title: Text("Your Menu"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:
                  pro.cardsItems != null && pro.cardsItems.length > 0
                      ? pro.cardsItems.length
                      : 0,
              itemBuilder: (ctx, i) {
                var list = pro.cardsItems[i];
                if (list == null) {
                  return Center(
                    child: Container(),
                  );
                } else {
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
                                list.cardName,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              IconButton(
                                onPressed: (){
                                  pro.assignCardId(pro.cardsItems[i].cardId);
                                pro.assignValue(pro.cardsItems[i].cardName, pro.cardsItems[i].minPrice);
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) => SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: EditMenuCard(),
                                        )));
                                },
                                icon: Icon(Icons.edit),
                              )
                            ],
                          ),
                          ListView.separated(
                            separatorBuilder: (ctx,i){
                              return Divider();
                            },
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: list.item != null && list.item.length > 0 ? list.item.length : 0,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if(list.item[index].itemStatus == 0){
                                return Container();
                              }else{
                                return Row(
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        leading: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage("https://tripps.live/tripp_food/${list.item[index].itmeImg}")
                                              )
                                          ),
                                          height: 70,
                                          width: 70,
                                        ),
                                        title: Text(list.item[index].itemName),
                                        subtitle: Text(list.item[index].itemDescription.length >= 17 ? "${list.item[index].itemDescription.substring(0,17)}...." : "${list.item[index].itemDescription}....",style: TextStyle(),),
                                        trailing: Text("${list.item[index].itemPrice.toString()} SAR"),
                                      ),
                                    ),
                                    IconButton(icon: Icon(Icons.edit), onPressed: (){
                                      pro.assignItemEditVals(list.item[index].itemName,list.item[index].itemPrice.toString(),list.item[index].itemDescription,list.item[index].itmeImg,list.item[index].itemId);
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => EditCardItems()
                                      ));
                                    }),
                                    IconButton(icon: Icon(Icons.delete), onPressed: (){
                                      pro.deleteCardItem(list.item[index].itemId).then((value){
                                        pro.showCardItems(context);
                                      });
                                    }),
                                  ],
                                );
                              }
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text("from ${list.minPrice} SAR"),
                          Row(
                            children: [
                              Expanded(
                                child: OutlineButton(
                                  highlightedBorderColor: kThemeColor,
                                  onPressed: (){
                                    pro.getCardId = pro.cardsItems[i].cardId;
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => AddMoreMenuFields()
                                  ));
                                  },
                                  child: Text("Add More"),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: (){
                                  pro.deleteCard(pro.cardsItems[i].cardId, context, i);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Add More Menu Fields",
                    textAlign: TextAlign.center,
                  ),
                  MaterialButton(
                    color: kThemeColor,
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => SingleChildScrollView(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: AddCardBottomSheet(),
                              )));
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
// Widget previousCardItems(){
//   return OfferCard(
//     deletCard: (){
//       pro.deleteCard(provider.cardList[i].cardId, context, i);
//     },
//     editCard: (){
//       pro.assignCardId(provider.cardList[i].cardId);
//       pro.assignValue(provider.cardList[i].cardName, provider.cardList[i].cardMinPrice);
//       showModalBottomSheet(
//           context: context,
//           isScrollControlled: true,
//           builder: (context) => SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.only(
//                     bottom: MediaQuery.of(context)
//                         .viewInsets
//                         .bottom),
//                 child: EditMenuCard(),
//               )));
//     },
//     addItems: (){
//       pro.getCardId = provider.cardList[i].cardId;
//       Navigator.push(context, MaterialPageRoute(
//           builder: (context) => AddMoreMenuFields()
//       ));
//     },
//     children: provider.cardList[i].listItem,
//     title: provider.cardList[i].cardName,
//     price: "from ${provider.cardList[i].cardMinPrice}SAR",
//   );
// }