// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  final String id;
  final String username;
  final String email;
  final String fcm;
  final bool verification;
  final String phone;
  final bool phoneVerification;
  final String userType;
  final String profile;
  final String userToken;

  LoginResponseModel({
    required this.id,
    required this.username,
    required this.email,
    required this.fcm,
    required this.verification,
    required this.phone,
    required this.phoneVerification,
    required this.userType,
    required this.profile,
    required this.userToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    id: json["_id"],
    username: json["username"],
    email: json["email"],
    fcm: json["fcm"],
    verification: json["verification"],
    phone: json["phone"],
    phoneVerification: json["phoneVerification"],
    userType: json["userType"],
    profile: json["profile"],
    userToken: json["userToken"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "email": email,
    "fcm": fcm,
    "verification": verification,
    "phone": phone,
    "phoneVerification": phoneVerification,
    "userType": userType,
    "profile": profile,
    "userToken": userToken,
  };
}
