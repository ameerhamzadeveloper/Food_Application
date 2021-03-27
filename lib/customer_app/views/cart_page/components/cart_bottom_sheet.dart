import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/resturant_app/views/home/menu/components/add_menu_inputs.dart';
import 'package:food_delivery_app/resturant_app/model/resturant_menu_provider.dart';
import 'package:food_delivery_app/resturant_app/model/menu_list.dart';
import 'package:provider/provider.dart';

class CartBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MenuProvider>(context);
    final listProv = Provider.of<MenuLists>(context);
    return Container(
      child: new Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

              ],
            ),
          )
        ],
      ),
    );
  }
}
