import 'dart:io';

import 'package:http/http.dart' as http;

import '../Models/translate_model.dart';

List<TranslateModel> chatList = [];

class TranslateTextRepo {
  Future<void> translateText() async {
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              'https://translation.googleapis.com/language/translate/v2?key=AIzaSyDbiFfCX2AtmNFLWFRcOSKr_sKYjfRl-h8&q=how are you&target=ar'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var model =
            translateModelFromJson(await response.stream.bytesToString());
        chatList.add(model);
      }

      // return response.statusCode;
    } on SocketException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }
}
