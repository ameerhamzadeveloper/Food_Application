import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/resturant_app/model/menu_list.dart';
import 'package:food_delivery_app/resturant_app/model/resturant_menu_provider.dart';
import 'package:food_delivery_app/resturant_app/views/home/menu/components/add_menu_inputs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddMoreMenuFields extends StatefulWidget {
  @override
  _AddMoreMenuFieldsState createState() => _AddMoreMenuFieldsState();
}

class _AddMoreMenuFieldsState extends State<AddMoreMenuFields> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MenuProvider>(context);
    final listPr = Provider.of<MenuLists>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add More Menu Offers"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Item Name",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Item Price",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: AddMenuInputs(
                      hintText: "e.g Pizza",
                      onTap: (val) {
                        provider.itemName = val;
                      },
                    ),
                  ),
                  Expanded(
                    child: AddMenuInputs(
                      hintText: "SR 100",
                      onTap: (val) {
                        provider.itemPrice = val;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Item Description",
                style: TextStyle(fontSize: 20),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Type something about item",
                      border: InputBorder.none,
                    ),
                    onChanged: (val){
                      provider.itemDescription = val;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Item Photo",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                child: provider.itemImage == null
                    ? OutlineButton(
                        onPressed: () {
                          provider.pickItemImage();
                        },
                        child: Text("Chose a photo"),
                      )
                    : Container(
                        height: 200,
                        child: provider.showItemImage(),
                      ),
              ),
              MaterialButton(
                color: kThemeColor,
                height: 40,
                onPressed: () async {
                  provider.addCardItems();
                  await provider.showCardItems(context);
                   provider.itemImage = null;
                  Navigator.pop(context);
                },
                child: Text(
                  "Add Item",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
