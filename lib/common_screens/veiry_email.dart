import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/models/sign_up_model.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:provider/provider.dart';

class VerifyEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _pinEditingController = TextEditingController();
    final provider = Provider.of<SignUpModel>(context);
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
        title: Text("Verify Code",style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Code is sent to\n${provider.email}"),
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
                  provider.setCode(val);
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
                  provider.verifyEmail(context);
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
