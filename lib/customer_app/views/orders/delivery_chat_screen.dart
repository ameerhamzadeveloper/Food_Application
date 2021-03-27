import 'package:flutter/material.dart';
class DeliveryChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Text("Chat",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Type Message"
                      ),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.send), onPressed: (){})
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
