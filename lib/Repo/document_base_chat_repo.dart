import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../Models/api_keys.dart';
import '../Models/chat_model.dart';

class DocumentBaseChatRepo {
  static List<Map<String, dynamic>> chatBotMessages = [
    {
      'role': 'system',
      'content':
          'You are a friendly Saudi guide that guides tourists in Saudi Arabia. limit your responses to maximum 100 words'
    },
    {
      'role': 'user',
      'content':
          'I\'m a tourist in Saudi Arabia. Can you guide me to Saudi Arabia? Would that be possible?'
    },
    {
      'role': 'assistant',
      'content':
          'I am happy to help you. Of course, I can guide you in Saudi Arabia. How can I assist you?'
    },
  ];

  static List<Map<String, dynamic>> clearMessages = [
    {
      'role': 'system',
      'content':
          'You are a friendly Saudi guide that guides tourists in Saudi Arabia. limit your responses to maximum 100 words'
    },
    {
      'role': 'user',
      'content':
          'I\'m a tourist in Saudi Arabia. Can you guide me to Saudi Arabia? Would that be possible?'
    },
    {
      'role': 'assistant',
      'content':
          'I am happy to help you. Of course, I can guide you in Saudi Arabia. How can I assist you?'
    },
  ];

  static Future<int> interactWithChatBot(
      {required dynamic message,
      List<Map<String, dynamic>>? recommendationList}) async {
    var user_dict = {
      'role': 'user',
      'content': '${message}. limit your answer to 50 words'
    };
    if (recommendationList == null) {
      chatBotMessages.add(user_dict);
    } else {
      chatBotMessages.add(user_dict);
    }

    try {
      final url = Uri.parse('https://api.openai.com/v1/chat/completions');
      // Replace with your actual API key

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiKeys.chatBotApi}',
      };

      final requestBody = {
        'messages': recommendationList ?? chatBotMessages,
        "model": "gpt-3.5-turbo",
        "temperature": 0.7,
      };

      final response =
          await http.post(url, headers: headers, body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        var content = responseBody['choices'][0]['message']["content"];

        var chatBotDict = {'role': 'assistant', 'content': content};

        chatBotMessages.add(chatBotDict);
        print('=======length ${content.toString().length}');

        print(content);
        ChatModel.chatBotResponse = content;
        return response.statusCode;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return response.statusCode;
      }
    } on Exception catch (e) {
      rethrow;
      // TODO
    }
  }




static  Future<int> getDocumentResponse({
    required String fileIndex,
    required String message,
  }) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://askodel.jmminnovations.com/file_chatbot'));
      request.fields.addAll({
        'user_id': FirebaseAuth.instance.currentUser?.uid ?? '',
        'file_index': fileIndex,
        'message': message
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
      var data =   jsonDecode(await response.stream.bytesToString());

        ChatModel.chatBotResponse = data['status'];
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
