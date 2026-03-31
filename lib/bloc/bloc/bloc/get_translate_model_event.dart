part of 'get_translate_model_bloc.dart';

@immutable
abstract class GetTranslateModelEvent {}

class FetchGetTranslateEvent extends GetTranslateModelEvent {

  final String text;
  final String from;
  final String to;

  FetchGetTranslateEvent({
    required this.text,
    required this.from,
    required this.to,
  });
}