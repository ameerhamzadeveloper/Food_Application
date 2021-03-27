import 'package:flutter/material.dart';

class PersonalRadioButtons extends StatelessWidget {
  final String title;
  final int radio1Value;
  final int radio2Value;
  final grupValue;
  final Function radio1ValueOnChange;
  final Function radio2ValueOnChange;
  PersonalRadioButtons(
      {this.radio1Value,
        this.radio1ValueOnChange,
        this.radio2Value,
        this.radio2ValueOnChange,
        this.title,
        this.grupValue});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            Divider(
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Radio(
                  value: radio1Value,
                  groupValue: grupValue,
                  onChanged: radio1ValueOnChange,
                ),
                Text(
                  'Yes',
                  style: new TextStyle(fontSize: 16.0),
                ),
                Radio(
                  value: radio2Value,
                  groupValue: grupValue,
                  onChanged: radio2ValueOnChange,
                ),
                Text(
                  'No',
                  style: new TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
