import 'dart:convert';

GetLanguagesModel getLanguagesModelFromJson(String str) =>
    GetLanguagesModel.fromJson(json.decode(str));

class GetLanguagesModel {
  List<Language> languages;

  GetLanguagesModel({
    required this.languages,
  });

  factory GetLanguagesModel.fromJson(Map<String, dynamic> json) {
    return GetLanguagesModel(
      languages: List<Language>.from(
        json["languages"].map((x) => Language.fromJson(x)),
      ),
    );
  }
}

class Language {
  String language; // code (en, es)
  String name;     // English, Spanish

  Language({
    required this.language,
    required this.name,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      language: json["language"] ?? "",
      name: json["name"] ?? "",
    );
  }
}