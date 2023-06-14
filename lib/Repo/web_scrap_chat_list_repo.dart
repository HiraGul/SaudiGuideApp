import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saudi_guide/Models/chat_model.dart';

class WebScrapChatListRepo {
  static Future<int> getScrap(
      {required String id,
      required String message,
      required String userId}) async {
    try {
      var request = http.MultipartRequest('POST',
          Uri.parse('http://askodel.jmminnovations.com/Scrap_data_chat'));
      request.fields
          .addAll({'user_id': userId, 'documants_id': id, 'message': message});

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = json.decode(await response.stream.bytesToString());
        ChatModel.webScrapMessage = data['message'];
        print(data['message']);

        //   print(data['data']);

        return response.statusCode;
      } else {
        print(response.reasonPhrase);
        return response.statusCode;
      }
    } on Exception {
      rethrow;
      // TODO
    }
  }
}
