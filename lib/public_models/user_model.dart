// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.email,
    this.branchEmail,
    this.lat,
    this.lng,
    this.address,
    this.isSuspended = false,
    this.suspendReason,
    this.image,
    this.token,
    this.name,
    this.phone,
  });
  String? name;
  String? phone;

  String? email;
  String? branchEmail;
  String? lat;
  String? lng;
  String? address;
  bool isSuspended;
  String? suspendReason;
  String? image;
  String? token;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
        branchEmail: json["branch_email"],
        lat: json["lat"],
        lng: json["lng"],
        address: json["address"],
        isSuspended: json["is_suspended"].toString() == "1",
        suspendReason: json["suspend_reason"],
        image: json["image"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "branch_email": branchEmail,
        "lat": lat,
        "lng": lng,
        "address": address,
        "is_suspended": isSuspended,
        "suspend_reason": suspendReason,
        "image": image,
        "token": token,
      };
}
