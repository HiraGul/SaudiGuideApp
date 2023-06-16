
import 'package:http/http.dart' as http;
import 'package:saudi_guide/Models/user_data.dart';
import 'package:saudi_guide/Repo/recomentation_repo/chat_bot_repo.dart';

import '../Models/chat_model.dart';
import '../Models/land_mark_controller.dart';

class RecommendationRepo {



  static UserData userData = UserData(userAge: '', gender: '', userLocation: '', monthlyIncome: '', nationality: '', country: '', purpose: '',);

  static Map<String,dynamic> getMyPrompt() {

    var subCategory = RecommendationModel.recommendedRegion.join(' , ');
    var userAge = "${userData.userAge}";
    var gender = "${userData.gender}";
    var userLocation = "Riyadh";
    var monthlyIncome = "${userData.monthlyIncome}";
    var nationality = "${userData.nationality}";
    var limitResponse = "Limit your answer to maximum 100 words";
    // print('================== sub category');
    print(subCategory);
    if(RecommendationModel.title == 'Food & Drinks'){
      return {
        "message" : "I am tourist ${userAge} years "
        "old and of "
            "${nationality} nationality, with a monthly income of ${monthlyIncome} "
            "riyals. They are particularly interested in this type "
            "of food the list are  ${subCategory}. "
            "They want recommendations for the city of ${userLocation}.",

            "type" : "Food"
      };

    }else if(RecommendationModel.title == 'Entertainments'){

      return {
        "message" :   "I am tourist ${userAge} years old and of "
            "${nationality} nationality, with a monthly income of ${monthlyIncome} "
            "riyals. They are particularly interested in this type "
            "of entertitment the list is ${subCategory}. "
            "They want recommendations for the city of ${userLocation}",
        "type" : "Entertainments"
      };
    }else if(RecommendationModel.title == 'Tourist'){
      return    {
        "message" :   "As a friendly travel guide, "
        "recommend me beautiful "
            "$subCategory destinations in ${userLocation} and "
            "nearby areas that are suitable for a "
            "${userAge}-year-old  ${gender} with a monthly "
            "salary of ${monthlyIncome} Riyal. Your recommendations "
            "should include details on the location, attractions, "
            "activities, and accommodations available at each destination."
            "Additionally, please ensure"
            " that your response stays within the token limit while still"
            " providing enough detail to help the traveler make an informed decision."
            "They want recommendations for the city of ${userLocation}",
        "type" : "Entertainments"
      };
    }else if(RecommendationModel.title == "Landmark" ){

    return  {
    "message" : "The tags are "
      "${LandMarkController.landMark?.description?.tags?.join(' , ')} and the "
          "description is "
          "${LandMarkController.landMark?.description?.captions?[0].text} ",
    "type" : "Landmark"
    };
    }else if(RecommendationModel.title == "Hajj" || RecommendationModel.title == "Umrah"){
    getUserRecommendation();
      return  {
        "message" : question,
        "type" : "worship"
      };
    }else {
      return  {
        "message" : '',
        "type" : "general"
      };
    }
  }

  static var  question = '';
  static  List<Map<String , dynamic >> getUserRecommendation(){
    var subCategory = RecommendationModel.recommendedRegion[0];
    var limitFaq = 'keep your response to 150 words.';
    var  limit="keep your response to 100 words.";
    if(subCategory == '${RecommendationModel.title} Steps'){
      question = 'Could you please provide me with the step-by-step guide for performing the ${RecommendationModel.title}?, give the response in points';
    }else if(subCategory == '${RecommendationModel.title} Preparation'){
      question = 'What are the essential preparations that need to be made for ${RecommendationModel.title}?", give the response in points';
    }else if(subCategory == '${RecommendationModel.title} Tips'){
      question = 'Could you please provide me with some useful tips for performing ${RecommendationModel.title}?,give the response in points';
    }else if(subCategory == '${RecommendationModel.title} FAQ\'S'){
      question = 'Could you please provide me to some frequently asked '
          'questions (FAQs) about ${RecommendationModel.title}? with brief answers,give the response in points';

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






