part of 'get_translate_model_bloc.dart';

@immutable
sealed class GetTranslateModelState {}

final class GetTranslateModelInitial extends GetTranslateModelState {}
final class GetTranslateModelLoading extends  GetTranslateModelState {}
class  GetTranslateModelLoaded  extends  GetTranslateModelState {
  final   GetTranslateModel getTranslateModel;
  // final TextEditingController controller = TextEditingController();
   GetTranslateModelLoaded  ({
    required this. getTranslateModel,
   });

}

final class GetTranslateModelError extends  GetTranslateModelState {
  final String message;
  GetTranslateModelError (this.message);

}













// part of 'get_current_weather_model_bloc.dart';

// @immutable
// sealed class GetCurrentWeatherModelState {}

// final class GetCurrentWeatherModelInitial extends GetCurrentWeatherModelState {}

// final class GetCurrentWeatherModelLoading extends GetCurrentWeatherModelState {}

// class GetCurrentWeatherModelLoaded extends GetCurrentWeatherModelState {
//   final GetCurrentWeatherModel getCurrentWeatherModel;

//   GetCurrentWeatherModelLoaded({
//     required this.getCurrentWeatherModel,
//   });
// }

// final class GetCurrentWeatherModelError extends GetCurrentWeatherModelState {
//   final String message;

//   GetCurrentWeatherModelError(this.message);
// }