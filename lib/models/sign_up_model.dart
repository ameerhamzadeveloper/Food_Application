import 'dart:convert';
import 'package:food_delivery_app/delivery_boy_app/views/home_page/home_page.dart';
import 'package:food_delivery_app/resturant_app/views/home/resturant_home.dart';
import 'package:food_delivery_app/routes/routes_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/common_screens/veiry_email.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/common_screens/sign_up_role.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_delivery_app/routes/routes_names.dart';

class SignUpModel extends ChangeNotifier {

  bool isSignUp = true;
  bool isLoading = false;
  bool isCodeSent = false;
  String email;
  String password;
  String role;
  dynamic id;
  String storedEmail;
  String code;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _verificationId;

  void setEmail(String val){
    email = val;
  }
  void setRole(String val){
    role = val;
  }
  void setPass(String val){
    password = val;
  }

  void setCode(String val){
    code = val;
  }

// Text Phonre Auth
 phoneAuth({number,context}) async {
   print(number);
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: number,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, int resendToken) {
              // showDialog(context, "+923073057807", verificationId);
//           Get.dialog(AlertDialog(
//             title: Text(
//               "Enter The Code",
//               style: TextStyle(color: UIDataColors.commonColor),
//             ),
//             backgroundColor: Colors.transparent,
//             content: Container(
//               height: 200,
//               child: Column(
//                 children: [
//                   Text("kjbkbk"),
//                   // CommonTextField(
//                   //   controller: pincontroller,
//                   //   keyboardType: TextInputType.phone,
//                   //   validator: (String value) {
//                   //     if (value.isEmpty) {
//                   //       return 'Enter the code';
//                   //     }
//                   //     return null;
//                   //   },
//                   //   labelText: 'Enter Code',
//                   //   hintText: 'Enter Code',
//                   // ),
//                   RaisedButton(
//                     // sms code
//                     onPressed: () async {
//                       var smscode = number;
//                       PhoneAuthCredential phoneauthcredential =
//                           PhoneAuthProvider.credential(
//                               verificationId: verificationId, smsCode: smscode);
//                       var result =
//                           await _firebaseAuth.signInWithCredential(phoneauthcredential);
//                       User user = result.user;
//                       if (user != null) {
// //                         collectionReference.doc(result.user.uid).set({
// //                           "FirstName": " ",
// //                           "LastName": " ",
// //                           "Email": " ",
// //                           "PhoneNumber": user.phoneNumber,
// //                           "Image": null,
// //                           "reference":"null",
// // //                          "reference": user.displayName +
// // //                              '-' +
// // //                              loginController.ref,
// //                         });
//                         // appController.storage
//                         //     .write("loggedin", user.refreshToken)
//                         //     .then((value) {
//                         //   Get.toNamed(UIData.homeRoute);
//                         // });
//                       }
//                     },
//                     child: Text(
//                       "Verify",
//                       style: TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.bold),
//                     ),
//                     color: Colors.amber,
//                   ),
//                 ],
//               ),
//             ),
//           )
//           );
            showDialog(context, number, verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
        
  }

  void showDialog(context,number,verificationId) {
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 300,
          child: SizedBox.expand(child: MaterialButton(color:Colors.orangeAccent, onPressed: ()async{
             var smscode = number;
            //           PhoneAuthCredential phoneauthcredential =
            //               PhoneAuthProvider.credential(
            //                   verificationId: verificationId, smsCode: smscode);
            //           var result =
            //               await _firebaseAuth.signInWithCredential(phoneauthcredential);
            //           User user = result.user;
            final AuthCredential credential = PhoneAuthProvider.credential(
verificationId: verificationId,
smsCode: smscode,
);
try {
var firebaseUser =
await FirebaseAuth.instance.signInWithCredential(credential);
print("Login Successful");
print(firebaseUser.user);
// Navigator.pushReplacementNamed(context, 'homepage');

} catch (e) {
  print("Login not successful");
  Navigator.pop(context);
}
          },child:Text("Press"))),
          margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}
  // Signup user with phone number
  //   onVerifyCode(String number, BuildContext context, countryCode) async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: '+92$number',
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await FirebaseAuth.instance
  //             .signInWithCredential(credential)
  //             .then((value) async {
  //           if (value.user != null) {
  //             // Navigator.pushAndRemoveUntil(
  //             //     context,
  //             //     MaterialPageRoute(builder: (context) => Home()),
  //             //     (route) => false);
  //           }
  //         });
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         print(e.message);
  //       },
  //       codeSent: (String verficationID, int resendToken) {
  //         // setState(() {
  //           verificationId = verficationID;
  //           notifyListeners();
  //         // });
  //       },
  //       codeAutoRetrievalTimeout: (String verificationID) {
  //         // setState(() {
  //           verificationId = verificationID;
  //           notifyListeners();
  //         // });
  //       },
  //       timeout: Duration(seconds: 120));
  // }
//   Future<void> onVerifyCode(String number, BuildContext context, countryCode) async {
//     isCodeSent = true;
//     final PhoneVerificationCompleted verificationCompleted =
//         (AuthCredential phoneAuthCredential)async {
//       _firebaseAuth
//           .signInWithCredential(phoneAuthCredential);
//           // .then((UserCredential value) {
// //         if (value.user.displayName != null && value.user != null) {
// //           // Handle loogged in state
// //           print(value.user.phoneNumber);
// // //           Navigator.pushAndRemoveUntil(
// // //               context,
// // //               MaterialPageRoute(
// // //                 builder: (context) =>BottomNavBar(
// // // //                  user: value.user,
// // //                 ),
// // //               ),
// // //                   (Route<dynamic> route) => false);
// //         } else if (value.user != null && value.user.displayName == null) {
// //           MaterialPageRoute(
// //             builder: (context) => SignRole(),
// //           );
// //         } else {
// //           Text("Error validating OTP, try again");
// //         }
//       // }).catchError((error) {
//       //   Text("Something went wrong");
//       // });
//     };
// //     final authResult = await _firebaseAuth.signInWithCredential(phoneAuthCredential).catchError((error) {
// //     // do something with the error
// //     print(error);
// // });
//     final PhoneVerificationFailed verificationFailed = (authException) {
//       Text(authException.message);
//       isCodeSent = false;
//     };

//     final PhoneCodeSent codeSent =
//         (String verificationId, [int forceResendingToken]) async {
//       _verificationId = verificationId;
//     };
//     final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
//         (String verificationId) {
//       _verificationId = verificationId;
//     };

//     await _firebaseAuth.verifyPhoneNumber(
//         phoneNumber: "+923073057807",
//         timeout: const Duration(seconds: 60),
//         verificationCompleted: verificationCompleted,
//         verificationFailed: verificationFailed,
//         codeSent: codeSent,
//         codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
//   }

  // on code submit
//   void onFormSubmitted(
//       TextEditingController _pinEditingController, BuildContext context,) async {


//  try {
//                   await FirebaseAuth.instance
//                       .signInWithCredential(PhoneAuthProvider.credential(
//                           verificationId: verificationId, smsCode: _pinEditingController.text))
//                       .then((value) async {
//                     if (value.user != null) {
//                       print(value.user.uid);
//                       // Navigator.pushAndRemoveUntil(
//                       //     context,
//                       //     MaterialPageRoute(builder: (context) => Home()),
//                       //     (route) => false);
//                     }
//                   });
//                 } catch (e) {
//                   FocusScope.of(context).unfocus();
//                   print("invalid otp");
//                   // _scaffoldkey.currentState
//                   //     .showSnackBar(SnackBar(content: Text('invalid OTP')));
//                 }




//     AuthCredential _authCredential = PhoneAuthProvider.credential(
//         verificationId: _verificationId, smsCode: _pinEditingController.text);

//     _firebaseAuth
//         .signInWithCredential(_authCredential)
//         .then((UserCredential value) {
//       if (value.user != null && value.user.displayName != null) {
//         // Handle loogged in state
//         print(value.user.phoneNumber);
// //         Navigator.pushAndRemoveUntil(
// //             context,
// //             MaterialPageRoute(
// //               builder: (context) => BottomNavBar(
// // //                user: value.user,
// //               ),
// //             ),
// //                 (Route<dynamic> route) => false);
//       } else if (value.user.displayName == null && value.user != null) {
//         MaterialPageRoute(
//           builder: (context) => SignRole(),
//         );
//       } else {
//         Text("Error validating OTP, try again");
//       }
//     }).catchError((error) {
//       Text("Something went wrong");
//     });
//   }
  void loading() {
    isLoading = false;
    notifyListeners();
  }
  // signup into signin by bool value
  void changeIntoSignup() {
    isSignUp = !isSignUp;
    notifyListeners();
  }
  String error;
  void emptyError(){
    error = null;
    notifyListeners();
  }

  // showing error for email sign up
  Widget showError() {
    if (error != null) {
      return Container(
        color: Colors.yellow,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
            SizedBox(
              width: 5.0,
            ),
            Expanded(
              child: Text(
                error,
                style: kEmailError,
              ),
            )
          ],
        ),
      );
    } else {
      return SizedBox(
        height: 0,
      );
    }
  }

  // signUp user with email password
  void signUpUser(BuildContext context) async {
    print(email);
    print(password);
    // await OneSignal.shared.sendTag(email, "yes");
    var url =
        "${kServerUrlName}signup.php";
    http.Response response = await http.post(url,
        body: ({
          'email': email,
          'pass': password,
        }),
        headers: {'Accept': 'application/json'});
    var dec = json.decode(response.body);
    if(response.statusCode == 200){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => VerifyEmail()));
    }else{
      showError();
    }
  }

  // signin user
  void signInUser(BuildContext context) async {
    print(email);
    print(password);
    String url = "${kServerUrlName}login.php";
    http.Response response = await http.post(url,body: ({
      'email':email,
      'password' :password,
    }));
    var de = jsonDecode(response.body);
    if(response.statusCode == 200){
      switch(de['data'][0]['status']){
        case 0:
          error = "Incorrect password";
          loading();
          break;
        case 1:
          email = de['data'][0]['email'];
          id = de['data'][0]['id'];
          storeValInSharedPref();
          saveRoleinSharedPref(de['data'][0]['role']);
          switch(de['data'][0]['role']){
            case '1':
              Navigator.pushReplacementNamed(context, navigationBar);
              break;
            case '2':
              Navigator.pushReplacementNamed(context, resturantHome);
              break;
            case '3':
              Navigator.pushReplacementNamed(context, deliHome);
          }
          break;
        case 2:
          loading();
          error = "Account is Not Verified";
          break;
        case 3:
          loading();
          error = "Account doesn't exist";
          break;
      }

      // status 0 password incorrect
      // status 1 everything is okay sucess
      // status 2 account not verified
      // staus 3 account doesnt exist
    }else{
      error = "Network Error Try Again Later";
      loading();
    }
    notifyListeners();
  }

   storeValInSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', email);
    preferences.setString('id', id);
  }
   getStoredEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    storedEmail = preferences.getString('email');

  }
  getStoredId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
  }

  verifyEmail(BuildContext context) async {
    // getStoredEmail();
    // getStoredId();
    print(email);
    print(code);
    String url =
        "${kServerUrlName}verification.php";
    http.Response response = await http.post(url,body: ({
      'email' : email,
      'code' : code,
    }));
    var decode = jsonDecode(response.body);
    print(decode);
    if(decode['login'][0]['status'] == '1'){
      email = decode['login'][0]['email'];
      id = decode['login'][0]['id'];
      storeValInSharedPref();
      Navigator.pushReplacementNamed(context, signRole);
    }else{
      print("error");
    }
  }
  void saveRoleinSharedPref(String role)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('role', role);
  }

  void roleUpdate(int index) async {
    String url = "${kServerUrlName}role.php";
    saveRoleinSharedPref(index.toString());
    if(index == 1){
      http.Response response = await http.post(url,body: ({
        'id': id,
        'email': email,
        'role': index.toString(),

      }));
    }else if(index == 2){
      http.Response response = await http.post(url,body: ({
        'id': id,
        'email': email,
        'role': index.toString(),

      }));
    }else{
      http.Response response = await http.post(url,body: ({
        'id': id,
        'email': email,
        'role': index.toString(),
      }));
    }
  }

}
