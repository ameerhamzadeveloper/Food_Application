import 'package:flutter/material.dart';

class DropDownMenue extends StatelessWidget {
  final String value;
  final String title;
  final List<DropdownMenuItem> items;
  final Function onchanged;
  DropDownMenue({this.items, this.onchanged, this.value, this.title});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12)),
              child: DropdownButtonHideUnderline(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 5),
                  child: DropdownButton(
                    value: value,
                    items: items,
                    onChanged: onchanged,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
