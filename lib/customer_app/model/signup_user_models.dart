import 'dart:convert';

List<SignUpUser> signUpUserFromJson(String str) => List<SignUpUser>.from(json.decode(str).map((x) => SignUpUser.fromJson(x)));

String signUpUserToJson(List<SignUpUser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SignUpUser {
  SignUpUser({
    this.id,
    this.email,
    this.password,
    this.randomNumber,
    this.image,
  });

  String id;
  String email;
  String password;
  String randomNumber;
  String image;

  factory SignUpUser.fromJson(Map<String, dynamic> json) => SignUpUser(
    id: json["id"],
    email: json["email"],
    password: json["password"],
    randomNumber: json["random_number"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "password": password,
    "random_number": randomNumber,
    "image": image,
  };
}

