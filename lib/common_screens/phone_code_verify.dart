import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/common_screens/sign_up_role.dart';
import 'package:food_delivery_app/customer_app/views/profile/create_profile.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import '../constants.dart';
class PhoneCodeVerify extends StatelessWidget {
  String phone;
  CountryCode code;
  PhoneCodeVerify({this.phone,this.code});
  @override
  Widget build(BuildContext context) {
    TextEditingController _pinEditingController = TextEditingController();
    String currentText;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        title: Text("Verify Phone",style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Code is sent to\n$code$phone"),
              SizedBox(height: 20,),
              Image.asset("images/iphone.png",height: 200,width: 200,),
              SizedBox(height: 20,),
              PinInputTextField(
                pinLength: 6,
                decoration: kPinDecoration,
                controller: _pinEditingController,
                autoFocus: true,
                onChanged: (val){
                  currentText = val;
                },
                textInputAction: TextInputAction.done,
                onSubmit: (pin) {
                  if (pin.length == 6) {

                  } else {

                  }
                },
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn't recieve code?",style: TextStyle(color: Colors.grey),),
                  FlatButton(onPressed: (){}, child: Text("Request again"))
                ],
              ),
              SizedBox(height: 20,),
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                color: kThemeColor,
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => SignRole()
                  ));
                },
                child: Text("Verify",style: TextStyle(fontSize: 22,color: Colors.white),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
