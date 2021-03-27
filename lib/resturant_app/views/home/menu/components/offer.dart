import 'package:flutter/material.dart';

class Offer extends StatelessWidget {
  final String title;
  final String discription;
  final String image;
  final String itemPrice;
  final Function delete;
  final Function edit;
  Offer({this.discription, this.image, this.title,this.edit,this.itemPrice,this.delete});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          discription,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Image.network(
                        image,
                        height: 50,
                        width: 80,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: edit,
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: delete,
                        icon: Icon(Icons.delete),
                      )
                    ],
                  )
                ],
              ),
              Text(itemPrice)
            ],
          ),
        ),
      ),
    );
  }
}
