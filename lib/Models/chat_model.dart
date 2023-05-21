class ChatModel {
  final String message;
  final bool isHuman;
  final DateTime dateTime;

  static String  recommendationResponse = '';
  static String  chatBotResponse = '';
  static String  landMarkResponse = '';

  ChatModel({
    required this.message,
    required this.isHuman,
    required this.dateTime
  });}




class RecommendationModel{


  static String title = '';
  static List<String> recommendedRegion = [];
  static String message = '';

  // final String title;
  //
  //
  //
  // final String message;
  // String area ;


  //RecommendationModel({required this.title ,required this.message, this.area = ''});
}