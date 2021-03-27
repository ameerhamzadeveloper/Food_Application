import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/resturant_app/model/resturant_menu_provider.dart';
import 'package:food_delivery_app/resturant_app/model/menu_list.dart';
import 'package:provider/provider.dart';

class EditMenuCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final menuPro = Provider.of<MenuProvider>(context);
    final listPro = Provider.of<MenuLists>(context);
    return Container(
      child: new Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Add New Menu Field",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 2.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: TextField(
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: "Lebel Name",
                                border: InputBorder.none,
                              ),
                              controller: menuPro.cardNameController,
                              onChanged: (val){
                                menuPro.editedCardName = val;
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 2.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Minimum Price",
                                border: InputBorder.none,
                              ),
                              onChanged: (val){
                                menuPro.editedCardMinPrice = val;
                              },
                              controller: menuPro.cardMinPriceController,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    color: kThemeColor,
                    onPressed: () {
                      // listPro.clearAllList();
                      menuPro.editMenuCard(context);
                      Navigator.pop(context);
                    },
                    child: Text("Done"),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
