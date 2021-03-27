import 'dart:convert';

AllResturants allResturantsFromJson(String str) => AllResturants.fromJson(json.decode(str));

String allResturantsToJson(AllResturants data) => json.encode(data.toJson());

class AllResturants {
  AllResturants({
    this.data,
  });

  List<Datum> data;

  factory AllResturants.fromJson(Map<String, dynamic> json) => AllResturants(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.fName,
    this.lName,
    this.bName,
    this.vertical,
    this.verticalSegment,
    this.cuisine,
    this.city,
    this.contactNo,
    this.email,
    this.bAddress,
    this.mySelfie,
    this.resutrantSelfie,
    this.idFront,
    this.idBack,
    this.signupId,
    this.franchise,
    this.delivery,
    this.deliApplication,
    this.owner,
    this.noOfBranches,
    this.comercialReg,
    this.lat,
    this.long,
  });

  String id;
  String fName;
  String lName;
  String bName;
  String vertical;
  String verticalSegment;
  String cuisine;
  String city;
  String contactNo;
  String email;
  String bAddress;
  String mySelfie;
  String resutrantSelfie;
  String idFront;
  String idBack;
  String signupId;
  String franchise;
  String delivery;
  String deliApplication;
  String owner;
  String noOfBranches;
  String comercialReg;
  String lat;
  String long;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    fName: json["f_name"],
    lName: json["l_name"],
    bName: json["b_name"],
    vertical: json["vertical"],
    verticalSegment: json["vertical_segment"],
    cuisine: json["cuisine"],
    city: json["city"],
    contactNo: json["contact_no"],
    email: json["email"],
    bAddress: json["b_address"],
    mySelfie: json["my_selfie"],
    resutrantSelfie: json["resutrant_selfie"],
    idFront: json["id_front"],
    idBack: json["id_back"],
    signupId: json["signup_id"],
    franchise: json["franchise"],
    delivery: json["delivery"],
    deliApplication: json["deli_application"],
    owner: json["owner"],
    noOfBranches: json["no_of_branches"],
    comercialReg: json["comercial_reg"],
    lat: json["lat"],
    long: json["long"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "f_name": fName,
    "l_name": lName,
    "b_name": bName,
    "vertical": vertical,
    "vertical_segment": verticalSegment,
    "cuisine": cuisine,
    "city": city,
    "contact_no": contactNo,
    "email": email,
    "b_address": bAddress,
    "my_selfie": mySelfie,
    "resutrant_selfie": resutrantSelfie,
    "id_front": idFront,
    "id_back": idBack,
    "signup_id": signupId,
    "franchise": franchise,
    "delivery": delivery,
    "deli_application": deliApplication,
    "owner": owner,
    "no_of_branches": noOfBranches,
    "comercial_reg": comercialReg,
    "lat": lat,
    "long": long,
  };
}
