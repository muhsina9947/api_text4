import 'package:api_text4/Repositary/Api/GetTranslateModel/Get_Translate_Model.dart';
import 'package:api_text4/Repositary/Api/GetTranslateModelApi/Get_Translate_Model_Api.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'get_translate_model_event.dart';
part 'get_translate_model_state.dart';

class GetTranslateModelBloc
    extends Bloc<GetTranslateModelEvent, GetTranslateModelState> {
  GetTranslateModelApi getTranslateModelApi = GetTranslateModelApi();

  GetTranslateModelBloc() : super(GetTranslateModelInitial()) {
    /// 🔥 IMPORTANT CHANGE HERE
    on<FetchGetTranslateEvent>((event, emit) async {
      emit(GetTranslateModelLoading());

      try {
        final result = await getTranslateModelApi.get(
          text: event.text,
          from: event.from,
          to: event.to,
        );

        print("RESULT: ${result.result}"); // 👈 add

        emit(GetTranslateModelLoaded(getTranslateModel: result));
      } catch (e) {
        print("ERROR: $e"); // 👈 add this
        emit(GetTranslateModelError(e.toString()));
      }
    });
  }
}
