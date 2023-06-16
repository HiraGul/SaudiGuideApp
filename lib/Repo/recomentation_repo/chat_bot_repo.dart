import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart'as http;
import 'package:saudi_guide/Models/api_keys.dart';
import 'package:saudi_guide/Models/chat_model.dart';
import 'package:saudi_guide/Repo/recommendation_repo.dart';
import 'package:saudi_guide/Utils/shared_prefs.dart';
class ChatBotRepo{

  static Future <int> chatBotApi({required String message}) async {

    RecommendationRepo.userData =await  MySharedPrefs.getUserData() ??RecommendationRepo.userData;
    print('=====================type ${RecommendationRepo.getMyPrompt()['type']}');
    print('=====================message\n ${RecommendationRepo.getMyPrompt()['message']}');
    try {
      var request = http.MultipartRequest('POST', Uri.parse('http://askodel.jmminnovations.com/chatbot'));
      request.fields.addAll({
        'user_id': FirebaseAuth.instance.currentUser!.uid,
        'message': message,
        // This will check the user selected recommendation
        'type':RecommendationRepo.getMyPrompt()['type']
      });

      http.StreamedResponse response = await request.send();

      print('=============== response status code ${response.statusCode}');
      if (response.statusCode == 200) {
        var data = json.decode(await response.stream.bytesToString());
        ChatModel.chatBotResponse = data['response'];
        return response.statusCode;
      }
      else {
        print(response.reasonPhrase);
        return response.statusCode;
      }
    } on Exception catch (e) {
      rethrow;
      // TODO
    }
  }




 static Future<int> askWeatherFromBot({required String message})async{

    try {
      var request = http.MultipartRequest('POST', Uri.parse('http://askodel.jmminnovations.com/weather-chat'));
      request.fields.addAll({
        'message': message
      });


      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
       var data =  json.decode(await response.stream.bytesToString());
        ChatModel.chatBotResponse = data['response'];

        return response.statusCode;
      }
      else {
        print(response.reasonPhrase);
        return response.statusCode;
      }
    } on Exception catch (e) {
      rethrow;
      // TODO
    }

  }

















}