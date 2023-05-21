import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:saudi_guide/Cubits/translate_list_cubit.dart';

import '../Models/translate_model.dart';

class TranslateTextRepo {
  // List<TranslateModel> chatList = [];

  Future<int> translateText(BuildContext context, text, language) async {
    var newLanguage = language;
    if (language == 'urdu') {
      language = 'ur';
    } else if (language == 'Arabic') {
      language = 'ar';
    } else if (language == 'hindi') {
      language = 'hi';
    } else if (language == "French") {
      language = 'fr';
    } else if (language == 'spanish') {
      language = 'es';
    } else {
      language = 'bn';
    }
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              'https://translation.googleapis.com/language/translate/v2?key=AIzaSyDbiFfCX2AtmNFLWFRcOSKr_sKYjfRl-h8&q=$text&target=$language'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var model =
            translateModelFromJson(await response.stream.bytesToString());
        model.data!.detectedText = "$text in $newLanguage";
        // chatList.add(model);
        context.read<TranslateListCubit>().addItem(model);
      }

      return response.statusCode;
    } on SocketException {
      return 501;
    } catch (e) {
      return 400;
    }
  }
}
