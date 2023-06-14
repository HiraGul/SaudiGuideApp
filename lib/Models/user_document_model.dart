// To parse this JSON data, do
//
//     final userDocumentModel = userDocumentModelFromJson(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

UserDocumentModel userDocumentModelFromJson(String str) => UserDocumentModel.fromJson(json.decode(str));

String userDocumentModelToJson(UserDocumentModel data) => json.encode(data.toJson());

class UserDocumentModel {
  final List<Documents> document;

  UserDocumentModel({
    required this.document,
  });

  factory UserDocumentModel.fromJson(DocumentSnapshot<Map<String, dynamic>> json,) => UserDocumentModel(
    document: List<Documents>.from(json["document"].map((x) => Documents.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "document": List<dynamic>.from(document.map((x) => Documents.toJson( model: x))),
  };
}

class Documents {
  final String fileName;
  final String url;

  Documents({
    required this.fileName,
    required this.url,
  });

  factory Documents.fromJson(Map<String, dynamic> json) => Documents(
    fileName: json["file_name"],
    url: json["url"],
  );

 static Map<String, dynamic> toJson({required Documents model}) => {
    "file_name": model.fileName,
    "url": model.url,
  };
}
