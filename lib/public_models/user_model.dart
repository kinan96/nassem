// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.token,
    this.expiresAt,
    this.financialYear,
    this.userInfo,
  });

  String? token;
  String? expiresAt;
  String? financialYear;
  UserInfo? userInfo;

  factory UserModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      UserModel(
        token: json["token"],
        expiresAt: json["expiresAt"],
        financialYear: json["financialYear"],
        userInfo: UserInfo.fromJson(json["userInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "expiresAt": expiresAt,
        "financialYear": financialYear,
        "userInfo": userInfo?.toJson(),
      };
}

class UserInfo {
  UserInfo({
    this.id,
    this.userName,
    this.nameArabic,
    this.nameEnglish,
    this.organizationId,
    this.branchId,
    this.cashboxId,
    this.email,
    this.mobile,
    this.isAdmin = false,
  });

  String? id;
  String? userName;
  String? nameArabic;
  String? nameEnglish;
  String? organizationId;
  String? branchId;
  String? cashboxId;
  String? email;
  String? mobile;
  bool isAdmin;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        userName: json["userName"],
        nameArabic: json["nameArabic"],
        nameEnglish: json["nameEnglish"],
        organizationId: json["organizationID"],
        branchId: json["branchID"],
        cashboxId: json["cashboxID"],
        email: json["email"],
        mobile: json["mobile"],
        isAdmin: json["isAdmin"].toString() == "true",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "nameArabic": nameArabic,
        "nameEnglish": nameEnglish,
        "organizationID": organizationId,
        "branchID": branchId,
        "cashboxID": cashboxId,
        "email": email,
        "mobile": mobile,
        "isAdmin": isAdmin,
      };
}
