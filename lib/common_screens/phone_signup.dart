import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:food_delivery_app/common_screens/phone_code_verify.dart';

GlobalKey<FormState> _key = GlobalKey<FormState>();

class PhoneSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CountryCode countryCode;
    String _phoneController;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Continue with phone",style: TextStyle(color: Colors.black),),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter your\nmobile number",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "We'll Text you a verification code. message and data rates may apply",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      CountryCodePicker(
                        onChanged: (val){
                          countryCode = val;
                        },
                        initialSelection: '+966',
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: TextFormField(
                          validator: (val){
                            if(val.isEmpty){
                              return "Please Provide Your Phone Number";
                            }else{
                              return null;
                            }
                          },
                          onChanged: (val) {
                            _phoneController = val;
                          },
                          decoration: InputDecoration(
                              hintText: "55 921 8735",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Card(
                    color: kThemeColor,
                    shadowColor: Colors.black,
                    elevation: 8.0,
                    child: Container(
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kThemeColor,
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if(_key.currentState.validate()){
                            // Provider.of<SignUpModel>(context,listen: false).onVerifyCode(_phoneController, context,countryCode);
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => PhoneCodeVerify(phone: _phoneController,code: countryCode,)
                            ));
                          }
                        },
                        child: Text(
                          "Continue",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

