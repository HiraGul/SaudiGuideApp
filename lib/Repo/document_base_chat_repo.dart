import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../Models/api_keys.dart';
import '../Models/chat_model.dart';

class DocumentBaseChatRepo {

static  Future<int> getDocumentResponse({
  required String userId,
    required String fileIndex,
    required String message,
  }) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://askodel.jmminnovations.com/file_chatbot'));
      request.fields.addAll({
        'user_id': userId,
        'file_index': fileIndex,
        'message': message
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
      var data =   jsonDecode(await response.stream.bytesToString());

        ChatModel.chatBotResponse = data['message'];
        return response.statusCode;
      } else {
        print(response.reasonPhrase);
        return response.statusCode;
      }
    } on Exception catch (e) {
      rethrow;
      // TODO
    }
  }
}
