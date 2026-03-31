// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:api_text4/Repositary/Api/GetLanguagesModel/Get_Languages_Model.dart';
import 'package:api_text4/Repositary/Api/GetLanguagesModelapi/Get_Languages_Model_api.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'get_languages_model_event.dart';
part 'get_languages_model_state.dart';

class GetLanguagesModelBloc
    extends Bloc<GetLanguagesModelEvent, GetLanguagesModelState> {

  GetLanguagesModelApi getLanguagesModelApi = GetLanguagesModelApi();

  GetLanguagesModelBloc() : super(GetLanguagesModelInitial()) {

    on<FetchGetLanguagesEvent>((event, emit) async {

      emit(GetLanguagesModelLoading());

      try {
        final result = await getLanguagesModelApi.get();

        emit(GetLanguagesModelLoaded(getLanguagesModel: result));

      } catch (e, stacktrace) {
        debugPrint("ERROR: $e");
        debugPrint("STACK: $stacktrace");

        emit(GetLanguagesModelError(e.toString()));
      }
    });
  }
}
















