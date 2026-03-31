import 'package:api_text4/Repositary/Api/GetLanguagesModel/Get_Languages_Model.dart';
// import 'package:api_text4/Repositary/Api/GetLanguagesModel/Model/GetLanguagesModel/Get_Languages_Model.dart';
import 'package:api_text4/Repositary/Api/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class GetLanguagesModelApi {
  final ApiClient apiClient = ApiClient();

  final String getlanguagesmodelapi = "/language/translate/v2/languages";

  Future<GetLanguagesModel> get() async {
    Response response = await apiClient.invokeAPI(
      getlanguagesmodelapi,
      'GET',
      {},
    );

    if (kDebugMode) {
      print(response.body);
    }
    return  getLanguagesModelFromJson(response.body);
  }
}

 

//    final String   getCurrentWeatherApi =
//   // "/api/weather/current?place=Delhi%2CIN&units=standard&lang=en&mode=json";
// //  "/api/weather/current?place=London%2CGB&units=standard&lang=en&mode=json";
//   // "/api/weather/current?place=Kochi%2CIN&units=standard&lang=en&mode=json";
//   "/api/weather/current?place=Kochi%2CIN&units=metric&lang=en&mode=json";

//  Future<GetCurrentWeatherModel> get() async {

//   Response response = await apiClient.invokeAPI(
//     getCurrentWeatherApi ,
//     'GET',
//     {},
//   );

//   if (kDebugMode) {
//     print(" getCurrentWeather RESPONSE: ${response.body}");
//   }

//   return getCurrentWeatherModelFromJson(response.body);
// }
// }


// // import 'package:api_text2/repository/api_client.dart';
// // import 'package:api_text2/repository/model/Get_Current_Weather_Model.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:http/http.dart';

// // class GetCurrentWeatherApi {
// //   final ApiClient apiClient = ApiClient();

// //   Future<GetCurrentWeatherModel> get(
// //       String city, String country) async {

// //     final String url =
// //         "/api/weather/current?place=${Uri.encodeComponent("$city,$country")}&units=standard&lang=en&mode=json";

// //     Response response = await apiClient.invokeAPI(
// //       url,
// //       'GET',
// //       {},
// //     );

// //     if (kDebugMode) {
// //       print("getCurrentWeather RESPONSE: ${response.body}");
// //     }

// //     return getCurrentWeatherModelFromJson(response.body);
// //   }
// // }

