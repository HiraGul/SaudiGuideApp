import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:saudi_guide/Models/chat_model.dart';
class RecommendationRepo{


  // static var conversationText = 'This is a conversation between a tourist and a helpful and knowledgeable Saudi guide.'
  //
  // 'Tourist: Hi, I\'m a tourist in Saudi Arabia. Can you guide me to Saudi Arabia? Would that be possible?'
  // "Saudi Guide: I am happy to help you. Of course, I can guide you in Saudi Arabia. How can I assist you?"
  // 'Tourist: Where can I find the best food in Madina?';
static var conversationText = '${RecommendationModel.title }${RecommendationModel.recommendedRegion.join(" , ") }';
  static Future<int> testingMessage({ String message = ''}) async {
     conversationText = message;
    var apiKey = 'lYfuIyr5fT0RAU8mgtV5wOOrTtjxXNp0ACMz22nL'; // This is your trial API key
    var url = 'https://api.cohere.ai/generate';

    try {
      var  requestBody = jsonEncode({
        'model': 'command',
        'prompt': conversationText,
        'max_tokens': 300,
        'temperature': 0.2,
        'k': 0,
        'stop_sequences': [],
        'return_likelihoods': 'NONE',
      });

      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        var  jsonResponse = json.decode(response.body);
        print(jsonResponse);
        //var  prediction = jsonResponse['generations'][0]['text'];
        ChatModel.recommendationResponse = jsonResponse["text"];
        // print('================================= response ');
        // print('Prediction: $prediction');
        return 200;
      } else {
        print('Request failed with status code ${response.statusCode}');
        return response.statusCode;
      }
    } on Exception catch (e) {

      rethrow;
      // TODO
    }


  }
}