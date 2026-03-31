// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;

// class ApiClient {
//   get basePath => null;

//  Future<http.Response> invokeAPI(
//     String path,
//     String method,
//     Object? body,
//   ) async {
//    final String url = basePath + path;

//     if (kDebugMode) {
//       print("🌐 Request URL: $url");
//       print("📦 Request Body: $body");
//     }

   
// final Map<String, String> headers = {
//       "X-RapidAPI-Key": "YOUR_RAPIDAPI_KEY",
//       "X-RapidAPI-Host": "imdb236.p.rapidapi.com",
//       "Content-Type": "application/json",
//     };

//   http.Response response;

//   try {
//       switch (method.toUpperCase()) {
//         case "POST":
//           response = await http.post(
//             Uri.parse(url),
//             headers: headers,
//             body: jsonEncode(body),
//           );
//           break;
//         case "GET":
//           response = await http.get(
//             Uri.parse(url),
//             headers: headers,
//           );
//           break;
//         default:
//           throw Exception("❌ Unsupported HTTP method: $method");
//       }

//       if (kDebugMode) {
//         print("📊 Response Status: ${response.statusCode}");
//         print("📨 Response Body: ${response.body}");
//       }

//       if (response.statusCode >= 400) {
//         log("🚨 API Error → $path : ${response.statusCode} : ${response.body}");
//         throw ApiException(_decodeBodyBytes(response), response.statusCode);
//       }

//       return response;
//     } catch (e) {
//       log("🔥 Exception in API call: $e");
//       rethrow;
//     }
//   }}
//     final Uri requestUri = Uri.parse(basePath + path);

//     final Map<String, String> headers = {
//       "X-RapidAPI-Key": "YOUR_RAPIDAPI_KEY",
//       "X-RapidAPI-Host": "imdb236.p.rapidapi.com",
//       "Content-Type": "application/json",
//     };

//     if (method.toUpperCase() == 'GET') {
//       return await http.get(requestUri, headers: headers);
//     } else {
//       return await http.post(
//         requestUri,
//         headers: headers,
//         body: jsonEncode(body),
//       );
//     }
//   }
// }




// import 'dart:convert';
// import 'dart:developer';
// import 'package:api_text/main.dart';
// import 'package:api_text/repository/api/api_exepction.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;

// import 'package:shared_preferences/shared_preferences.dart';

// class ApiClient {
 
//   Future<http.Response> invokeAPI(
//     String path,
//     String method,
//     Object? body, String s, param4, {
//     bool useToken = true,
//   }) async {
//     final preferences = await SharedPreferences.getInstance();
//     final token = preferences.getString('Token');

//     final String url = basePath + path;

//     if (kDebugMode) {
//       print("🌐 Request URL: $url");
//       print("📦 Request Body: $body");
//     }

//     Map<String, String> headers = {
//       'Content-Type': 'application/json',
//        'X-RapidAPI-Key': '23f4809d73msh9a79989444abeb4p149e1bjsn4643ea8957a3',
//       'X-RapidAPI-Host': 'imdb236.p.rapidapi.com',
//     };

//     if (useToken && token != null && token.isNotEmpty) {
//       headers['Authorization'] = 'Bearer $token';
//     }

//     http.Response response;

//     try {
//       switch (method.toUpperCase()) {
//         case "POST":
//           response = await http.post(
//             Uri.parse(url),
//             headers: headers,
//             body: jsonEncode(body),
//           );
//           break;
//         case "GET":
//           response = await http.get(
//             Uri.parse(url),
//             headers: headers,
//           );
//           break;
//         default:
//           throw Exception("❌ Unsupported HTTP method: $method");
//       }

//       if (kDebugMode) {
//         print("📊 Response Status: ${response.statusCode}");
//         print("📨 Response Body: ${response.body}");
//       }

//       if (response.statusCode >= 400) {
//         log("🚨 API Error → $path : ${response.statusCode} : ${response.body}");
//         throw ApiException(_decodeBodyBytes(response), response.statusCode);
//       }

//       return response;
//     } catch (e) {
//       log("🔥 Exception in API call: $e");
//       rethrow;
//     }
//   }


//   Future<http.Response> invokeAPIMultipart(
//     String path,
//     String method,
//     Map<String, String> fields,
//     List<http.MultipartFile> files, {
//     bool useToken = true,
//   }) async {
//     final preferences = await SharedPreferences.getInstance();
//     final token = preferences.getString('Token');
//     final String url = basePath + path;

//     if (kDebugMode) {
//       print("🌐 Multipart Request URL: $url");
//       print("📦 Multipart Fields: $fields");
//     }

//     var request = http.MultipartRequest(method.toUpperCase(), Uri.parse(url));

//     if (useToken && token != null && token.isNotEmpty) {
//       request.headers['Authorization'] = 'Bearer $token';
//     }

//     request.fields.addAll(fields);
//     request.files.addAll(files);

//     try {
//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);

//       if (kDebugMode) {
//         print("📊 Response Status: ${response.statusCode}");
//         print("📨 Response Body: ${response.body}");
//       }


//       if (response.statusCode >= 400) {
//         log("🚨 API Error → $path : ${response.statusCode} : ${response.body}");
//         throw ApiException(_decodeBodyBytes(response), response.statusCode);
//       }

//       return response;
//     } catch (e) {
//       log("🔥 Exception in multipart API call: $e");
//       rethrow;
//     }
//   }

//   String _decodeBodyBytes(http.Response response) {
//     try {
//       final bodyJson = jsonDecode(response.body) as Map<String, dynamic>;

//       if (bodyJson.containsKey('message')) {
//         return bodyJson['message'].toString();
//       } else if (bodyJson.containsKey('error')) {
//         return bodyJson['error'].toString();
//       } else if (bodyJson.containsKey('detail')) {
//         return bodyJson['detail'].toString();
//       }

//       return response.body;
//     } catch (_) {
//       return response.body;
//     }
//   }
// }





import 'dart:convert';
import 'dart:developer';
// import 'package:api_text/main.dart';
// import 'package:api_text/repository/api/api_exepction.dart';
// import 'package:api_text2/main.dart';
// import 'package:api_text2/repository/api_Exception.dart';
// import 'package:api_text3/main.dart';
// import 'package:api_text3/repository/api/api_%20exception.dart';
import 'package:api_text4/Repositary/Api/api_exception.dart';
import 'package:api_text4/main.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
 Future<http.Response> invokeAPI(
  String path,
  String method,
  Object? body, {
  bool useToken = true,
}) async {
  final preferences = await SharedPreferences.getInstance();
  final token = preferences.getString('Token');

  final String url = basePath  + path;

  if (kDebugMode) {
    print("🌐 Request URL: $url");
    print("📦 Request Body: $body");
  }

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'X-RapidAPI-Key':'23f4809d73msh9a79989444abeb4p149e1bjsn4643ea8957a3',
    'X-RapidAPI-Host':'deep-translate1.p.rapidapi.com', // ✅ FIXED
  };

  if (useToken && token != null && token.isNotEmpty) {
    headers['Authorization'] = 'Bearer $token';
  }

  http.Response response;

  try {
    switch (method.toUpperCase()) {
      case "POST":
        response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: body != null ? jsonEncode(body) : null, // ✅ FIXED
        );
        break;

      case "GET":
        response = await http.get(
          Uri.parse(url),
          headers: headers,
        );
        break;

      default:
        throw Exception("❌ Unsupported HTTP method: $method");
    }

    if (kDebugMode) {
      print("📊 Response Status: ${response.statusCode}");
      print("📨 Response Body: ${response.body}");
    }

    if (response.statusCode >= 400) {
      throw ApiException(_decodeBodyBytes(response), response.statusCode);
    }

    return response;
  } catch (e) {
    log("🔥 Exception in API call: $e");
    rethrow;
  }
}

  Future<http.Response> invokeAPIMultipart(
    String path,
    String method,
    Map<String, String> fields,
    List<http.MultipartFile> files, {
    bool useToken = true,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('Token');
    final String url = basePath + path;

    if (kDebugMode) {
      print("🌐 Multipart Request URL: $url");
      print("📦 Multipart Fields: $fields");
    }

    var request = http.MultipartRequest(method.toUpperCase(), Uri.parse(url));

    if (useToken && token != null && token.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    request.fields.addAll(fields);
    request.files.addAll(files);

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (kDebugMode) {
        print("📊 Response Status: ${response.statusCode}");
        print("📨 Response Body: ${response.body}");
      }

      if (response.statusCode >= 400) {
        log("🚨 API Error → $path : ${response.statusCode} : ${response.body}");
        throw ApiException(_decodeBodyBytes(response), response.statusCode);
      }

      return response;
    } catch (e) {
      log("🔥 Exception in multipart API call: $e");
      rethrow;
    }
  }

  String _decodeBodyBytes(http.Response response) {
    try {
      final bodyJson = jsonDecode(response.body) as Map<String, dynamic>;

      if (bodyJson.containsKey('message')) {
        return bodyJson['message'].toString();
      } else if (bodyJson.containsKey('error')) {
        return bodyJson['error'].toString();
      } else if (bodyJson.containsKey('detail')) {
        return bodyJson['detail'].toString();
      }

      return response.body;
    } catch (_) {
      return response.body;
    }
  }
}
