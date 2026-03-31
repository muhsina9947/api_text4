import 'package:api_text4/bloc/bloc/bloc/get_translate_model_bloc.dart';
import 'package:api_text4/bloc/bloc/get_languages_model_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:api_text4/UI/loginpage.dart';
// import 'package:api_text4/bloc/get_languages_model_bloc.dart';
import 'firebase_options.dart';

String basePath = "https://deep-translate1.p.rapidapi.com";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 898),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
         providers: [
    BlocProvider(
      create: (_) => GetLanguagesModelBloc(),
    ),
    BlocProvider(
      create: (_) => GetTranslateModelBloc(),
    ),
  ],
          
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Translator App',
theme: ThemeData(
  brightness: Brightness.light,

  textTheme: GoogleFonts.montserratTextTheme().apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
  ),

  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.grey.shade400,
        width: 1.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.black,
        width: 1.5,
      ),
    ),
    hintStyle: const TextStyle(
      color: Colors.black,
    ),
  ),

  appBarTheme: const AppBarTheme(
    foregroundColor: Colors.black,
    backgroundColor: Colors.white,
  ),

  iconTheme: const IconThemeData(color: Colors.black),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
    ),
  ),
),

            /// 🔥 START SCREEN
            home: const Loginpage()
          ),
        );
      },
    );
  }
}