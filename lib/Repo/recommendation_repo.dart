import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/chat_model.dart';

class RecommendationRepo {
  //static var conversationText = '${RecommendationModel.title }${RecommendationModel.recommendedRegion.join(" , ") }';





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

    var apiKey =
        ''; // This is your trial API key
    var url = 'https://api.cohere.ai/generate';

    try {
      var requestBody = jsonEncode({
        'model': 'command',
        'prompt': prompt,
        'max_tokens': 450,
        'temperature': 0.9,
         'k': 11,

        // 'k': 0,  'max_tokens': 200,
        // 'temperature': 0.2,
        // 'k': 0,
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
    var gender = "male";
    var userLocation = "Madina";
    var monthlyIncome = "5000";
    var nationality = "indian";
    var limitResponse = "Limit your answer to maximum 100 words";
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
        "system" : "As a friendly travel guide, "
            "your task is to recommend beautiful "
            "$subCategory destinations in ${userLocation} and "
            "nearby areas that are suitable for a "
            "${userAge}-year-old  ${gender} with a monthly "
            "salary of ${monthlyIncome} Riyal. Your recommendations "
            "should include details on the location, attractions, "
            "activities, and accommodations available at each destination."
             "Additionally, please ensure"
            " that your response stays within the token limit while still"
            " providing enough detail to help the traveler make an informed decision.",

        "user" : ""
      };
      // return {
      //   "system" : 'You are a helpful and knowledgeable Saudi guide.'
      //       ' Your responsibility is to assist the tourist in recommending '
      //       'the beautiful tourist places based on their preferences'
      //       ' and budget. $limitResponse ',
      //   // user input
      //   "user"  : "${isUserCohere ? 'The tourist is': "I am tourist"} ${userAge} years old and of "
      //       "${nationality} nationality, with a monthly income of ${monthlyIncome} "
      //       "riyals. I am particularly interested in this type "
      //       "of places, ${subCategory}. "
      //       "Recommend me for the city of ${userLocation} and nearby areas."
      //
      // };



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
