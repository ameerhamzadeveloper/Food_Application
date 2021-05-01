import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:food_delivery_app/common_screens/phone_code_verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:food_delivery_app/models/sign_up_model.dart';
import 'package:provider/provider.dart';

GlobalKey<FormState> _key = GlobalKey<FormState>();

class PhoneSignUp extends StatefulWidget {
  @override
  _PhoneSignUpState createState() => _PhoneSignUpState();
}

class _PhoneSignUpState extends State<PhoneSignUp> {
  String phoneNo;

  String smsCode;

  String verificationId;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpModel>(context);
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
                          keyboardType: TextInputType.number,
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
                        onPressed: ()async {
                          if(_key.currentState.validate()){
                            
                            // await onVerifyCode(_phoneController, context,countryCode).whenComplete((){
                               Navigator.push(context, MaterialPageRoute(
                                builder: (context) => PhoneCodeVerify(phone: _phoneController,code: countryCode,verificationCode:verificationId)
                            ));
                            
                            // var number = "$countryCode$_phoneController";
                            // print(number.toString());
                            // verifyPhone(context,number);
                            // await provider.phoneAuth(number:number, context:context).then((value){
                              
                              //  Navigator.push(context, MaterialPageRoute(
                              //   builder: (context) => PhoneCodeVerify(phone: _phoneController,code: countryCode,)
                            // ));
                            // });
                           
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

   onVerifyCode(String number, BuildContext context, countryCode) async {
     print(countryCode.toString());
     print(number.toString());
    await FirebaseAuth.instance.verifyPhoneNumber(
      
        phoneNumber: '$countryCode$number',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              //  Navigator.push(context, MaterialPageRoute(
              //                   builder: (context) => PhoneCodeVerify(phone: number,code: countryCode,verificationCode:verificationId)
              //               ));
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(builder: (context) => Home()),
              //     (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            verificationId = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            verificationId = verificationID;
            // notifyListeners();
          });
        },
        timeout: Duration(seconds: 120));
  }

  signIn(context,number) {
    FirebaseAuth.instance
        .signInWithPhoneNumber(number,)
        .then((user) {
      Navigator.of(context).pushReplacementNamed('/homepage');
    }).catchError((e) {
      print(e);
    });
  }
}

