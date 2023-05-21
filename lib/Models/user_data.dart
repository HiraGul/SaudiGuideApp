

// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  String userAge;
  String gender;
  String userLocation;
  String monthlyIncome;
  String nationality;
  String country;
  String purpose;

  UserData({
    required this.userAge,
    required this.gender,
    required this.userLocation,
    required this.monthlyIncome,
    required this.nationality,
    required this.country,
    required this.purpose,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    userAge: json["userAge"],
    gender: json["gender"],
    userLocation: json["userLocation"],
    monthlyIncome: json["monthlyIncome"],
    nationality: json["nationality"],
    country: json["country"],
    purpose: json["purpose"],
  );

  Map<String, dynamic> toJson() => {
    "userAge": userAge,
    "gender": gender,
    "userLocation": userLocation,
    "monthlyIncome": monthlyIncome,
    "nationality": nationality,
    "country": country,
    "purpose": purpose,
  };
}











// class UserData {
//   String userAge;
//   String gender;
//   String userLocation;
//   String monthlyIncome;
//   String nationality;
//   String country;
//   String purpose;
//
//   UserData(this.country, this.gender, this.monthlyIncome, this.nationality,
//       this.purpose, this.userAge, this.userLocation);
//
//   Map<String, dynamic> toJson() =>
//       {
//         "userAge": userAge,
//         "gender": gender,
//         "userLocation": userLocation,
//         "monthlyIncome": monthlyIncome,
//         "nationality": nationality,
//         "country": country,
//         "purpose": purpose
//       };
//
//   factory UserData.fromJson(Map<String, dynamic> json) {
//     return UserData(
//       json['country'],
//       json['gender'],
//       json['monthlyIncome'],
//       '',
//       json['purpose'],
//       json['userAge'],
//       json['userLocation'],);
//
//   }
// }
