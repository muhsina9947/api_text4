// To parse this JSON data, do
//
//     final getTranslateModel = getTranslateModelFromJson(jsonString);

import 'dart:convert';

GetTranslateModel getTranslateModelFromJson(String str) => GetTranslateModel.fromJson(json.decode(str));

String getTranslateModelToJson(GetTranslateModel data) => json.encode(data.toJson());

class GetTranslateModel {
    String status;
    String result;

    GetTranslateModel({
        required this.status,
        required this.result,
    });
factory GetTranslateModel.fromJson(Map<String, dynamic> json) {
  return GetTranslateModel(
    status: json["status"] ?? "",
   result: (json["data"]?["translations"]?["translatedText"] as List?)?.isNotEmpty == true
    ? json["data"]["translations"]["translatedText"][0]
    : "",
  );
}

    Map<String, dynamic> toJson() => {
        "status": status,
        "result": result,
    };
}
