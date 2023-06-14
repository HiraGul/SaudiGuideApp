// To parse this JSON data, do
//
//     final webScrapListModel = webScrapListModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

WebScrapListModel webScrapListModelFromJson(String str, String docId) =>
    WebScrapListModel.fromJson(json.decode(str), docId);

String webScrapListModelToJson(WebScrapListModel data) =>
    json.encode(data.toJson());

class WebScrapListModel {
  final String data;
  final String websiteName;
  final bool isPredefined;
  final String url;
  final String docId;
  final DateTime dateTime;

  WebScrapListModel(
      {required this.data,
      required this.websiteName,
      required this.isPredefined,
      required this.url,
      required this.docId, required this.dateTime,});

  factory WebScrapListModel.fromJson(
          DocumentSnapshot<Map<String, dynamic>> json, String docId) =>
      WebScrapListModel(
        dateTime: json['date_time'].toDate(),
          data: json["data"],
          websiteName: json["website_name"],
          isPredefined: json["is_predefined"],
          url: json["url"],
          docId: docId);

  Map<String, dynamic> toJson() => {
        "data": data,
        "website_name": websiteName,
        "is_predefined": isPredefined,
        "url": url,
      };
}
