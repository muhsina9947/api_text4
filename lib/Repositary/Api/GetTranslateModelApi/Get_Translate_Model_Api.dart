// import 'dart:convert';

// import 'package:api_text4/Repositary/Api/GetTranslateModel/Get_Translate_Model.dart';
// import 'package:api_text4/Repositary/Api/api_client.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart';

// class GetTranslateModelApi {
//   final ApiClient apiClient = ApiClient();

//   final String getTranslatemodelapi = "/translate";

//   Future<GetTranslateModel> get({
//     required String text,
//     required String from,
//     required String to,
//   }) async {
//     /// 🔥 QUERY PARAMETERS
//     Map<String, String> queryParams = {"text": text, "from": from, "to": to};

//     Response response = await apiClient.invokeAPI(
//       getTranslatemodelapi,
//       "GET",
//       queryParams,
//     );

//     if (kDebugMode) {
//       print("RESPONSE: ${response.body}");
//     }

//     return getTranslateModelFromJson(response.body);
//   }
// }
// import 'dart:convert';

import 'package:api_text4/Repositary/Api/GetTranslateModel/Get_Translate_Model.dart';
import 'package:api_text4/Repositary/Api/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class GetTranslateModelApi {
  final ApiClient apiClient = ApiClient();

  final String getTranslatemodelapi = "/language/translate/v2";

  Future<GetTranslateModel> get({
  required String text,
  required String from,
  required String to,
}) async {

  final body = {
    "q": text,
    "source": from,
    "target": to,
  };

  Response response = await apiClient.invokeAPI(
    getTranslatemodelapi,
    "POST",
    body,
  );

  if (kDebugMode) {
    print("SENT TEXT: $text");
    print("FROM: $from → TO: $to");
    print("STATUS: ${response.statusCode}");
    print("RESPONSE: ${response.body}");
  }

  if (response.statusCode == 200) {
    return getTranslateModelFromJson(response.body);
  } else {
    throw Exception("Translation failed");
  }
}}

// import 'package:api_text4/Repositary/Api/GetLanguagesModel/Get_Languages_Model.dart';
// // import 'package:api_text4/Repositary/Api/GetLanguagesModel/Model/GetLanguagesModel/Get_Languages_Model.dart';
// import 'package:api_text4/Repositary/Api/api_client.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart';

// class GetLanguagesModelApi {
//   final ApiClient apiClient = ApiClient();

//   final String getlanguagesmodelapi = "/language/translate/v2/languages";

//   Future<GetLanguagesModel> get() async {
//     Response response = await apiClient.invokeAPI(
//       getlanguagesmodelapi,
//       'GET',
//       {},
//     );

//     if (kDebugMode) {
//       print(response.body);
//     }
//     return  getLanguagesModelFromJson(response.body);
//   }
// }
