import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/resturant_app/views/home/resturant_home.dart';
import 'package:image_picker/image_picker.dart';

class ResturantProfile extends StatefulWidget {
  @override
  _ResturantProfileState createState() => _ResturantProfileState();
}

class _ResturantProfileState extends State<ResturantProfile> {
  // FirebaseAuth auth = FirebaseAuth.instance;
  // var user;
  // void checkUserId() {
  //   var firebaseUser = auth.currentUser.uid;
  //   setState(() {
  //     user = firebaseUser;
  //     print("at profile page user id got $user");
  //   });
  // }

  String resturantName;
  String description;
  String startFrom;
  String deliveryFee;
  File resturantImage;


  Widget showResturantImage() {
    if (resturantImage != null) {
      return Image.file(
        resturantImage,
        fit: BoxFit.fill,
        height: 120,
        width: 120,
      );
    } else {
      return Center(
        child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kThemeColor, width: 5)),
            child: Image.asset(
              "images/profile.png",
              height: 120,
              width: 120,
            )),
      );
    }
  }

  // uploadImageAndResturantInfo() async {
  //   // int num = 555555;
  //   // var random = Random().nextInt(num);
  //   // try {
  //   //   StorageTaskSnapshot storageReference = await FirebaseStorage.instance
  //   //       .ref()
  //   //       .child('resturants/resturant_images/resturant$random.jpg')
  //   //       .putFile(resturantImage)
  //   //       .onComplete;
  //   //   final String downloadURL = await storageReference.ref.getDownloadURL();
  //   //   if (storageReference.error == null) {
  //   //     await firestore.collection('resturants').document(user).setData({
  //   //       'name': resturantName,
  //   //       'description': description,
  //   //       'start_from': startFrom,
  //   //       'delivery_fee': deliveryFee,
  //   //       'image': downloadURL
  //   //     }).then((value) {
  //   //       print("uploaded successfull");
  //   //       Navigator.pushReplacement(
  //   //         context,
  //   //         MaterialPageRoute(
  //   //           builder: (ctx) => ResturantHomePage(),
  //   //         ),
  //   //       );
  //   //     });
  //   //   }
  //   } catch (e) {
  //     print(e.message);
  //   }
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   checkUserId();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("Name"),
                ),
                TextField(
                  onChanged: (val) {
                    setState(() {
                      resturantName = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Name",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("Description"),
                ),
                TextField(
                  onChanged: (val) {
                    setState(() {
                      description = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Description",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("Delivery Fee"),
                ),
                TextField(
                  onChanged: (val) {
                    setState(() {
                      deliveryFee = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Delivery Fee",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("Start From"),
                ),
                TextField(
                  onChanged: (val) {
                    setState(() {
                      startFrom = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Start From",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("Image"),
                ),
                Container(
                  height: 250,
                  child: resturantImage == null
                      ? IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: () {

                          },
                        )
                      : showResturantImage(),
                ),
                MaterialButton(
                  color: kThemeColor,
                  onPressed: () {
                    // uploadImageAndResturantInfo();
                  },
                  child: Text("Upload Informations"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
