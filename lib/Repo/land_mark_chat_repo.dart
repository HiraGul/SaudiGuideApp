import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:saudi_guide/Models/api_keys.dart';
import 'package:saudi_guide/Models/chat_model.dart';
import 'package:saudi_guide/Models/land_mark_controller.dart';
import 'package:saudi_guide/Repo/recommendation_repo.dart';
class LandMarkChatRepo{



  static List<Map<String,dynamic>> chatBotMessages = [
    {'role': 'system', 'content': 'You are a friendly Saudi guide that guides tourists in Saudi Arabia. limit your responses to maximum 100 words'},
    {'role': 'user', 'content': 'I\'m a tourist in Saudi Arabia. Can you guide me to Saudi Arabia? Would that be possible?'},
    {'role': 'assistant', 'content': 'I am happy to help you. Of course, I can guide you in Saudi Arabia. How can I assist you?'},
  ];



  static List<Map<String,dynamic>> clearMessages =[
    {'role': 'system', 'content': 'You are a powerful AI model that specializes in generating detailed information about landmarks. Based on the'
        ' provided tags and description, your task '
        'is to expand on the details and provide a '
        'comprehensive overview of the landmark. Add'
        ' historical, cultural, architectural, or any other '
        'relevant information that would enhance the user\'s understanding of the landmark.'},
    {'role': 'user', 'content': "The tags are ${LandMarkController.landMark?.description?.tags} and the "
        "description is ${LandMarkController.landMark?.description?..captions?.join(' , ')} "
        ""},
  ];

  // static var conversationText = 'This is a conversation between a tourist and a helpful and knowledgeable Saudi guide.'
  //
  // 'Tourist: Hi, I\'m a tourist in Saudi Arabia. Can you guide me to Saudi Arabia? Would that be possible?'
  // "Saudi Guide: I am happy to help you. Of course, I can guide you in Saudi Arabia. How can I assist you?"
  // 'Tourist: Where can I find the best food in Madina?';


  static Future<int> interactWithChatBot({required dynamic message, List<Map<String, dynamic>>? recommendationList}) async {


  //  var user_dict= {'role': 'user', 'content': '${message}. limit your answer to 50 words'};
  //   if(recommendationList == null){
  //     chatBotMessages.add(user_dict);
  //   }else{
  //     RecommendationRepo.chatBotMessages.add(user_dict);
  //   }


    try {
      final url = Uri.parse('https://api.openai.com/v1/chat/completions');
      // Replace with your actual API key

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiKeys.chatGptApi}',
      };



      final requestBody = {
        'messages': recommendationList ?? chatBotMessages,
        "model": "gpt-3.5-turbo",
        "temperature": 0.7,


      };

      final response = await http.post(url, headers: headers, body: jsonEncode(requestBody));


      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        var content = responseBody['choices'][0]['message']["content"];

        var  chatBotDict =  {'role': 'assistant', 'content': content};

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












  static var  question = '';
  static  List<Map<String , dynamic >> getUserRecommendation(){
    var subCategory = RecommendationModel.recommendedRegion[0];
    var limitFaq = 'keep your response to 150 words.';
    var  limit="keep your response to 100 words.";
    if(subCategory == '${RecommendationModel.title} Steps'){
      question = 'Could you please provide me with the step-by-step guide for performing the ${RecommendationModel.title}? ';
    }else if(subCategory == '${RecommendationModel.title} Preparation'){
      question = 'What are the essential preparations that need to be made for ${RecommendationModel.title}?" ';
    }else if(subCategory == '${RecommendationModel.title} Tips'){
      question = 'Could you please provide me with some useful tips for performing ${RecommendationModel.title}?';
    }else if(subCategory == '${RecommendationModel.title} FAQ\'S'){
      question = 'Could you please provide me to some frequently asked '
          'questions (FAQs) about ${RecommendationModel.title}? with brief answers';

    }else{
      question = '';
    }


    return [
      {'role':'system', 'content':'You are a friendly Saudi guide that'
          ' guides tourists in Saudi Arabia to perform the '
          '${RecommendationModel.title} based on the tourist\'s query..'},


      {'role':'user', 'content':" I'm a tourist in Saudi "
          "Arabia, and I want to perform the ${RecommendationModel.title}. Can you guide me?"},


      {'role':'assistant', 'content':'Certainly! I can provide'
          ' you with all the necessary information and guidance '
          'for performing the ${RecommendationModel.title} in Saudi Arabia. Please let me '
          'know how I can assist you.'},
      {'role':'user', 'content':"$question ${RecommendationModel.title == "Hajj FAQ'S" || RecommendationModel.title == "Umrah FAQ'S" ?limitFaq :"$limit"}  "},
    ];

  }


}