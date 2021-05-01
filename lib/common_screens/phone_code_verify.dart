import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/common_screens/sign_up_role.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/models/sign_up_model.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
class PhoneCodeVerify extends StatefulWidget {
  final String phone;
  final CountryCode code;
  final String verificationCode;
  PhoneCodeVerify({this.phone,this.code,this.verificationCode});

  @override
  _PhoneCodeVerifyState createState() => _PhoneCodeVerifyState();
}

class _PhoneCodeVerifyState extends State<PhoneCodeVerify> {


  String verificationId;
  final TextEditingController _pinPutController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    // color: const Color.fromRGBO(43, 46, 66, 1),
    color:Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );



@override
  void initState() {
    onVerifyCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpModel>(context);
    return Scaffold(
      key:_scaffoldkey ,
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
              Text("Code is sent to\n${widget.code}${widget.phone}"),
              SizedBox(height: 20,),
              Image.asset("images/iphone.png",height: 200,width: 200,),
              SizedBox(height: 20,),
              Padding(
            padding: const EdgeInsets.all(30.0),
            child: PinPut(
              fieldsCount: 6,
              textStyle: const TextStyle(fontSize: 25.0, color: kThemeColor),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: verificationId, smsCode: pin))
                      .then((value) async {
                    if (value.user != null) {
                       FocusScope.of(context).unfocus();
                  _scaffoldkey.currentState
                      .showSnackBar(SnackBar(content: Text('VAllidated OTP')));
                      print(value.user.phoneNumber);
                      print("value.user.phoneNumber");
                      await provider.numberSignup(context,"${widget.code}${widget.phone}");
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => Home()),
                      //     (route) => false);
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  _scaffoldkey.currentState
                      .showSnackBar(SnackBar(content: Text('invalid OTP')));
                }
              },
            ),
          ),
              // PinInputTextField(
              //   pinLength: 6,
              //   decoration: kPinDecoration,
              //   controller: _pinEditingController,
              //   autoFocus: true,
              //   onChanged: (val){
              //     // setState(() {
              //       _pinEditingController.text = val;
              //     // });
              //   },
              //   textInputAction: TextInputAction.done,
              //   onSubmit: (pin)async {
              //     currentText = pin;
              //   },
              // ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn't recieve code?",style: TextStyle(color: Colors.grey),),
                  FlatButton(onPressed: (){}, child: Text("Request again"))
                ],
              ),
              SizedBox(height: 20,),
              // MaterialButton(
              //   minWidth: MediaQuery.of(context).size.width,
              //   height: 50,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10)
              //   ),
              //   color: kThemeColor,
              //   onPressed: (){
              //     print(_pinPutController.text);
              //     provider.onFormSubmitted(_pinPutController, context, widget.verificationCode);
                 
              //   },
              //   child: Text("Verify",style: TextStyle(fontSize: 22,color: Colors.white),),
              // )
            ],
          ),
        ),
      ),
    );
  }

 onVerifyCode() async {
     print(widget.code.toString());
     print(widget.phone.toString());
    await FirebaseAuth.instance.verifyPhoneNumber(
      
        phoneNumber: '${widget.code}${widget.phone}',
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


}
