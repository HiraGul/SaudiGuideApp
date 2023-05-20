// To parse this JSON data, do
//
//     final translateModel = translateModelFromJson(jsonString);

import 'dart:convert';

TranslateModel translateModelFromJson(String str) =>
    TranslateModel.fromJson(json.decode(str));

String translateModelToJson(TranslateModel data) => json.encode(data.toJson());

class TranslateModel {
  final Data? data;

  TranslateModel({
    this.data,
  });

  factory TranslateModel.fromJson(Map<String, dynamic> json) => TranslateModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final List<Translation>? translations;

  Data({
    this.translations,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        translations: json["translations"] == null
            ? []
            : List<Translation>.from(
                json["translations"]!.map((x) => Translation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "translations": translations == null
            ? []
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
      };
}

class Translation {
  final String? translatedText;
  final String? detectedSourceLanguage;

  Translation({
    this.translatedText,
    this.detectedSourceLanguage,
  });

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        translatedText: json["translatedText"],
        detectedSourceLanguage: json["detectedSourceLanguage"],
      );

  Map<String, dynamic> toJson() => {
        "translatedText": translatedText,
        "detectedSourceLanguage": detectedSourceLanguage,
      };
}
