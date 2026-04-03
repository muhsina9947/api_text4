import 'package:api_text4/UI/loginpage.dart';
import 'package:api_text4/bloc/bloc/bloc/get_translate_model_bloc.dart';
import 'package:api_text4/bloc/bloc/get_languages_model_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  final TextEditingController controller = TextEditingController();

  String fromLang = "en";
  String toLang = "es";

  late stt.SpeechToText speech;
  late FlutterTts flutterTts;

  String translatedText = "";
  String untranslatedText = "";
  bool isListening = false;

  @override
  void initState() {
    super.initState();

    speech = stt.SpeechToText();
    flutterTts = FlutterTts();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetLanguagesModelBloc>().add(FetchGetLanguagesEvent());
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  
  
  Future speak(String text) async {
    await flutterTts.setLanguage(toLang);
    await flutterTts.speak(text);
  }

 
 
  void startListening() async {
    bool available = await speech.initialize();

    if (available) {
      setState(() => isListening = true);

      speech.listen(
        onResult: (result) {
          setState(() {
            controller.text = result.recognizedWords;
          });
        },
      );
    }
  }

  void stopListening() {
    speech.stop();
    setState(() => isListening = false);
  }



  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Copied")));
  }

 
 
  String getLangName(List languages, String code) {
    try {
      return languages.firstWhere((l) => l.language == code).name;
    } catch (e) {
      return code.toUpperCase();
    }
  }

 
 
  void showLanguagePicker(BuildContext context, List languages) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return LanguagePickerSheet(
          languages: languages,
          onSelect: (code) {
            setState(() => toLang = code);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,

      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text("Language Translator"),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const Loginpage()),
              );
            },
          ),
        ],
      ),

      body: Container(
        color: Colors.grey.shade200,
        child: Column(
          children: [
          
          
            BlocBuilder<GetLanguagesModelBloc, GetLanguagesModelState>(
              builder: (context, state) {
                if (state is GetLanguagesModelLoaded) {
                  final languages = state.getLanguagesModel.languages;

                  return Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      
                      
                        Text(
                          getLangName(languages, fromLang),
                          style: const TextStyle(fontSize: 36,fontWeight: FontWeight.bold,),
                        ),

                      
                      
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            setState(() {
                              final temp = fromLang;
                              fromLang = toLang;
                              toLang = temp;
                            });
                          },
                        ),

                      
                      
                        GestureDetector(
                          onTap: () => showLanguagePicker(context, languages),
                          child: Row(
                            children: [
                              Text(
                                getLangName(languages, toLang),
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),

         
         
            Container(height: 1, color: Colors.grey.shade300),

          
          
            Expanded(
              child: Column(
                children: [
                
                
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                      
                      
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(fromLang.toUpperCase()),

                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isListening ? Icons.mic : Icons.mic_none,
                                  ),
                                  onPressed: () {
                                    isListening
                                        ? stopListening()
                                        : startListening();
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () => controller.clear(),
                                ),
                              ],
                            ),
                          ],
                        ),

                       
                       
                        TextField(
                          controller: controller,
                          maxLines: null,
                          decoration: const InputDecoration(
                            hintText: "Enter text",
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),

                 
                 
                  Container(
                    width: double.infinity,
                    color: Colors.grey.shade100,
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<GetTranslateModelBloc>().add(
                          FetchGetTranslateEvent(
                            text: controller.text,
                            from: fromLang,
                            to: toLang,
                          ),
                        );
                      },
                      child: const Text("Translate"),
                    ),
                  ),

                 
                 
                  Expanded(
                    child:
                        BlocBuilder<
                          GetTranslateModelBloc,
                          GetTranslateModelState
                        >(
                          builder: (context, state) {
                            if (state is GetTranslateModelLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (state is GetTranslateModelLoaded) {
                              translatedText = state.getTranslateModel.result;

                              return Container(
                                width: double.infinity,
                                color: Colors.white,
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  
                                  
                                    
                                    
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(toLang.toUpperCase()),

                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.copy),
                                              onPressed: () =>
                                                  copyText(translatedText),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.volume_up),
                                              onPressed: () =>
                                                  speak(translatedText),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 10),

                                    Text(
                                      translatedText,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              );
                            }

                            if (state is GetTranslateModelError) {
                              return const Center(
                                child: Text("Translation failed"),
                              );
                            }

                            return const SizedBox();
                          },
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🌍 LANGUAGE PICKER
class LanguagePickerSheet extends StatefulWidget {
  final List languages;
  final Function(String) onSelect;

  const LanguagePickerSheet({
    super.key,
    required this.languages,
    required this.onSelect,
  });

  @override
  State<LanguagePickerSheet> createState() => _LanguagePickerSheetState();
}

class _LanguagePickerSheetState extends State<LanguagePickerSheet> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    final filtered = widget.languages.where((lang) {
      return lang.name.toLowerCase().contains(search.toLowerCase());
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            decoration: const InputDecoration(hintText: "Search language"),
            onChanged: (value) {
              setState(() => search = value);
            },
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final lang = filtered[index];

              return ListTile(
                title: Text(lang.name),
                onTap: () => widget.onSelect(lang.language),
              );
            },
          ),
        ),
      ],
    );
  }
}
