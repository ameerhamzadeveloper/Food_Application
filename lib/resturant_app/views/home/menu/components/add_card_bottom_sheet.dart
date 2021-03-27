import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/resturant_app/views/home/menu/components/add_menu_inputs.dart';
import 'package:food_delivery_app/resturant_app/model/resturant_menu_provider.dart';
import 'package:food_delivery_app/resturant_app/model/menu_list.dart';
import 'package:provider/provider.dart';

class AddCardBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MenuProvider>(context);
    final listProv = Provider.of<MenuLists>(context);
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
                        child: AddMenuInputs(
                          hintText: "Lebel Name",
                          onTap: (val) {
                            provider.cardName = val;
                          },
                        ),
                      ),
                      Expanded(
                        child: AddMenuInputs(
                          hintText: "Minimum Price",
                          onTap: (val) {
                            provider.cardMinPrice = val;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    color: kThemeColor,
                    onPressed: () async {
                      await provider.addMenuCard(context);
                      Navigator.pop(context);
                      await provider.showCardItems(context);
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
