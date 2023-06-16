import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Models/chat_model.dart';
import '../../Repo/api_response.dart';
import '../../Repo/recomentation_repo/chat_bot_repo.dart';

part 'chat_bot_state.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  ChatBotCubit() : super(ChatBotInitial());

  getMessage(
      {dynamic message = '',

      }) async {
    emit(ChatBotLoading());

    print('=========== loading state ');
    try {
      var statusCode ;

      if(RecommendationModel.title == 'weather'){
         statusCode =  await ChatBotRepo.askWeatherFromBot(message: message);

      }else{
         statusCode =  await ChatBotRepo.chatBotApi(message: message);

      }


      if (statusCode == ApiResponse.ok) {
        print('=========== Loaded state ');

        emit(ChatBotLoaded(message:   ChatModel.chatBotResponse ));
      } else {
        print('=========== Error state  $statusCode ');

        print('==========stats code ${statusCode}');
        emit(
          ChatBotError(
            error: ApiResponse.getErrorMessage(statusCode: statusCode),
          ),
        );
      }
    } on Exception catch (e) {

      print('$e');
      if(e is SocketException){
        print('=========== Internet Exception state   ');

        emit(ChatBotError(error: ApiResponse.getErrorMessage(statusCode: 1000)));

      }else{
        print('=========== Exception ${e.toString()}  ');

        emit(ChatBotError(error:e.toString()));

      }

      // TODO
    }
  }
}

//  getMessage(
//       {dynamic message = '',
//       bool isRecommendedOption = false,
//       List<Map<String, dynamic>>? recommendationList}) async {
//     emit(ChatBotLoading());
//
//
//
//
//     try {
//       var result;
//       if (isRecommendedOption) {
//         result = await RecommendationRepo.getRecommendation(message: message);
//       } else if (LandMarkController.landMark != null) {
//         print('============ in land mark');
//         result = await LandMarkChatRepo.interactWithChatBot(
//             message: message, recommendationList: recommendationList);
//       } else {
//         result = await ChatBotRepo.interactWithChatBot(
//             message: message, recommendationList: recommendationList);
//       }
//
//       if (result == 200) {
//         emit(
//           ChatBotLoaded(
//             message: isRecommendedOption
//                 ? ChatModel.recommendationResponse
//                 : ChatModel.chatBotResponse,
//           ),
//         );
//       } else {
//         emit(ChatBotError(
//             error: ApiResponse.getErrorMessage(statusCode: result)));
//       }
//     } on Exception catch (e) {
//       print('$e');
//       emit(ChatBotError(error: ApiResponse.getErrorMessage(statusCode: 1000)));
//
//       // TODO
//     }
//   }
