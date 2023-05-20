class ChatModel {
  final String message;
  final bool isHuman;

  static String  recommendationResponse = '';

  ChatModel({
    required this.message,
    required this.isHuman,
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