import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/resturant_app/model/menu_list.dart';
import 'package:food_delivery_app/resturant_app/model/resturant_menu_provider.dart';
import 'package:food_delivery_app/resturant_app/views/home/menu/components/add_menu_inputs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditCardItems extends StatefulWidget {
  @override
  _EditCardItemsState createState() => _EditCardItemsState();
}

class _EditCardItemsState extends State<EditCardItems> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MenuProvider>(context);
    final listPr = Provider.of<MenuLists>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Item"),
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
                        provider.editeditemName = val;
                      },
                      controller: provider.itemNameController,
                    ),
                  ),
                  Expanded(
                    child: AddMenuInputs(
                      hintText: "SR 100",
                      onTap: (val) {
                        provider.itemPriceController = val;
                      },
                      controller: provider.itemPriceController,
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
                      provider.editeditemDes = val;
                    },
                    controller: provider.itemDesController,
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
                child: provider.editedItemImage == null
                    ? InkWell(
                  onTap: (){},
                  child: Image.network("https://tripps.live/tripp_food/${provider.itemImageController}"),
                ) :
                    provider.showEditedItemImage()
              ),
              MaterialButton(
                color: kThemeColor,
                height: 40,
                onPressed: () async {
                  await provider.editItems();
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
