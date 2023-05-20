import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/chat_model.dart';

class RecommendationRepo {
  //static var conversationText = '${RecommendationModel.title }${RecommendationModel.recommendedRegion.join(" , ") }';

  static var userInputCohere = "The tourist is 25 years old and of "
      "indian nationality, with a monthly income of 5000 "
      "riyals. They are particularly interested in this type "
      "of food the last are  ${RecommendationModel.recommendedRegion.join(' , ')}. "
      "They want recommendations for the city of Madina.";



  static var userInputGpt3 = '';

  // static var prompt = 'You are a helpful and knowledgeable Saudi guide.'
  //     ' Your responsibility is to assist the tourist in recommending '
  //     'the best food, drinks, and restaurants based on their preferences'
  //     ' and budget. $userInputCohere';

 static var prompt = '';

static var systemContent = '';
  static List<Map<String, dynamic>> chatBotMessages = [
    {
      'role': 'system',
      'content':systemContent
            // 'You are a helpful and knowledgeable Saudi guide. Your responsibility is to assist the tourist in recommending the best food, drinks, and restaurants based on their preferences and budget.'
    },
    {
      'role': 'user',
      'content':
        userInputGpt3
    },
    {
      'role': 'assistant',
      'content':
      ChatModel.recommendationResponse
    },
  ];


  static Future<int> getRecommendation({String message = ''}) async {


    var myPrompt = getMyPrompt(isUserCohere: true);
    prompt = '${myPrompt['system']} ${myPrompt['user']}';
    systemContent = myPrompt['system'];

    // ChatGPT 3 input
    userInputGpt3 = getMyPrompt(isUserCohere: false)['user'];
    //prompt = message;
    var apiKey =
        'lYfuIyr5fT0RAU8mgtV5wOOrTtjxXNp0ACMz22nL'; // This is your trial API key
    var url = 'https://api.cohere.ai/generate';

    try {
      var requestBody = jsonEncode({
        'model': 'command',
        'prompt': prompt,
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
        var jsonResponse = json.decode(response.body);
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


  static Map<String ,dynamic> getMyPrompt({required bool isUserCohere}){

    var subCategory = RecommendationModel.recommendedRegion.join(' , ');
    var userAge = "25";
    var userLocation = "Madina";
    var monthlyIncome = "5000";
    var nationality = "indian";
    var limitResponse = 'Keep in mind to limit your responses up to maximum 100 words';
    // print('================== sub category');
    print(subCategory);
    if(RecommendationModel.title == 'Food & Drinks'){
      return {
        "system" : 'You are a helpful and knowledgeable Saudi guide.'
            ' Your responsibility is to assist the tourist in recommending '
            'the best food, drinks, and restaurants based on their preferences'
            ' and budget. $limitResponse ',
        // user input
       "user"  : "${isUserCohere ? 'The tourist is': "I am tourist"}  ${userAge} years old and of "
            "${nationality} nationality, with a monthly income of ${monthlyIncome} "
            "riyals. They are particularly interested in this type "
            "of food the list are  ${subCategory}. "
            "They want recommendations for the city of ${userLocation}."

      };
    }else if(RecommendationModel.title == 'Entertainments'){

      return {
        "system" : 'You are a helpful and knowledgeable Saudi guide.'
            ' Your responsibility is to assist the tourist in recommending '
            'the best entertainment sources and places based on their preferences'
            ' and budget. $limitResponse ',
        // user input
        "user"  : "${isUserCohere ? 'The tourist is': "I am tourist"} ${userAge} years old and of "
            "${nationality} nationality, with a monthly income of ${monthlyIncome} "
            "riyals. They are particularly interested in this type "
            "of entertitment the list is ${subCategory}. "
            "They want recommendations for the city of ${userLocation}"

      };






    }else if(RecommendationModel.title == 'Tourist'){

      return {
        "system" : 'You are a helpful and knowledgeable Saudi guide.'
            ' Your responsibility is to assist the tourist in recommending '
            'the beautiful tourist places based on their preferences'
            ' and budget. $limitResponse ',
        // user input
        "user"  : "${isUserCohere ? 'The tourist is': "I am tourist"} ${userAge} years old and of "
            "${nationality} nationality, with a monthly income of ${monthlyIncome} "
            "riyals. They are particularly interested in this type "
            "of place the list are ${subCategory}. "
            "They want recommendations for the city of ${userLocation} and most nearby this areas."

      };



    }else {
      return {
        "system" : "",
        "user" : "",
      };
    }


  }



//   static getPrompt({required String recommendation}){
//
//     var subCategory = RecommendationModel.recommendedRegion.join(' , ');
//     var userAge = "25";
//     var userLocation = "Madina";
//     var monthlyIncome = "5000";
//     var nationality = "indian";
// var limitResponse = 'Keep in mind to limit your responses up to maximum 100 words';
//    // print('================== sub category');
//     print(subCategory);
//     if(RecommendationModel.title == 'Food & Drinks'){
//       return 'You are a helpful and knowledgeable Saudi guide.'
//           ' Your responsibility is to assist the tourist in recommending '
//           'the best food, drinks, and restaurants based on their preferences'
//           ' and budget. $limitResponse '
//           // user input
//           "The tourist is ${userAge} years old and of "
//       "${nationality} nationality, with a monthly income of ${monthlyIncome} "
//           "riyals. They are particularly interested in this type "
//           "of food the list are  ${subCategory}. "
//           "They want recommendations for the city of ${userLocation}.";
//     }else if(RecommendationModel.title == 'Entertainments'){
//
//       return 'You are a helpful and knowledgeable Saudi guide.'
//           ' Your responsibility is to assist the tourist in recommending '
//           'the best entertainment sources and places based on their preferences'
//           ' and budget. $limitResponse '
// // user input
//           "The tourist is ${userAge} years old and of "
//           "${nationality} nationality, with a monthly income of ${monthlyIncome} "
//           "riyals. They are particularly interested in this type "
//           "of entertitment the list is ${subCategory}. "
//           "They want recommendations for the city of ${userLocation}";
//
//
//
//
//
//     }else if(RecommendationModel.title == 'Tourist'){
//       return 'You are a helpful and knowledgeable Saudi guide.'
//     ' Your responsibility is to assist the tourist in recommending '
//     'the beautiful tourist places based on their preferences'
//     ' and budget. $limitResponse '
// // user input
//     "The tourist is ${userAge} years old and of "
//     "${nationality} nationality, with a monthly income of ${monthlyIncome} "
//     "riyals. They are particularly interested in this type "
//     "of place the list are ${subCategory}. "
//     "They want recommendations for the city of ${userLocation} and most nearby this areas.";
//
//
//     }else if(RecommendationModel.title == 'Hajj'){
//       return '';
//     }else if(RecommendationModel.title == 'Umrah'){
//       return '';
//     }else {
//       return '';
//     }
//
//
//   }



  static getSystemContent({required String recommendation}){

    var subCategory = RecommendationModel.recommendedRegion.join(' , ');
    var userAge = "25";
    var userLocation = "Madina";
    var monthlyIncome = "5000";
    var nationality = "indian";
    var limitResponse = 'Keep in mind to limit your responses up to maximum 100 words';
    print(subCategory);
    if(RecommendationModel.title == 'Food & Drinks'){
      return 'You are a helpful and knowledgeable Saudi guide.'
          ' Your responsibility is to assist the tourist in recommending '
          'the best food, drinks, and restaurants based on their preferences'
          ' and budget. $limitResponse '
      // user input
          "The tourist is ${userAge} years old and of "
          "${nationality} nationality, with a monthly income of ${monthlyIncome} "
          "riyals. They are particularly interested in this type "
          "of food the list are  ${subCategory}. "
          "They want recommendations for the city of ${userLocation}.";
    }else if(RecommendationModel.title == 'Entertainments'){

      return 'You are a helpful and knowledgeable Saudi guide.'
          ' Your responsibility is to assist the tourist in recommending '
          'the best entertainment sources and places based on their preferences'
          ' and budget. $limitResponse '
// user input
          "The tourist is ${userAge} years old and of "
          "${nationality} nationality, with a monthly income of ${monthlyIncome} "
          "riyals. They are particularly interested in this type "
          "of entertitment the list is ${subCategory}. "
          "They want recommendations for the city of ${userLocation}";





    }else if(RecommendationModel.title == 'Tourist'){
      return 'You are a helpful and knowledgeable Saudi guide.'
          ' Your responsibility is to assist the tourist in recommending '
          'the beautiful tourist places based on their preferences'
          ' and budget. $limitResponse '
// user input
          "The tourist is ${userAge} years old and of "
          "${nationality} nationality, with a monthly income of ${monthlyIncome} "
          "riyals. They are particularly interested in this type "
          "of place the list are ${subCategory}. "
          "They want recommendations for the city of ${userLocation} and most nearby this areas.";


    }else if(RecommendationModel.title == 'Hajj'){
      return '';
    }else if(RecommendationModel.title == 'Umrah'){
      return '';
    }else {
      return '';
    }


  }



}
