import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:saudi_guide/Cubits/translate_list_cubit.dart';

import '../Models/translate_model.dart';

class TranslateTextRepo {
  // List<TranslateModel> chatList = [];

  Future<void> translateText(BuildContext context, text) async {
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              'https://translation.googleapis.com/language/translate/v2?key=AIzaSyDbiFfCX2AtmNFLWFRcOSKr_sKYjfRl-h8&q=$text&target=ar'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var model =
            translateModelFromJson(await response.stream.bytesToString());
        // chatList.add(model);
        context.read<TranslateListCubit>().addItem(model);
      }

      // return response.statusCode;
    } on SocketException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }
}
