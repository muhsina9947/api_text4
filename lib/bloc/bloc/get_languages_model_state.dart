part of 'get_languages_model_bloc.dart';

@immutable
sealed class GetLanguagesModelState {}

final class GetLanguagesModelInitial extends GetLanguagesModelState {}

final class GetLanguagesModelLoading extends GetLanguagesModelState {}

final class GetLanguagesModelLoaded extends GetLanguagesModelState {
  final GetLanguagesModel getLanguagesModel;

  GetLanguagesModelLoaded({required this.getLanguagesModel});
}

final class GetLanguagesModelError extends GetLanguagesModelState {
  final String message;

  GetLanguagesModelError(this.message);
}
