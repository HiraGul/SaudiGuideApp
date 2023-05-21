import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:saudi_guide/Models/land_mark_controller.dart';
import 'package:saudi_guide/Repo/land_mark_chat_repo.dart';
import 'package:saudi_guide/Repo/recommendation_repo.dart';

import '../../Models/chat_model.dart';
import '../../Repo/api_response.dart';
import '../../Repo/recomentation_repo/chat_bot_repo.dart';

part 'chat_bot_state.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  ChatBotCubit() : super(ChatBotInitial());

  getMessage(
      {dynamic message = '',
      bool isRecommendedOption = false,
      List<Map<String, dynamic>>? recommendationList}) async {
    emit(ChatBotLoading());

    try {
      var result;
      if (isRecommendedOption) {
        result = await RecommendationRepo.getRecommendation(message: message);
      } else if (LandMarkController.landMark != null) {
        result = await LandMarkChatRepo.interactWithChatBot(
            message: message, recommendationList: recommendationList);
      } else {
        result = await ChatBotRepo.interactWithChatBot(
            message: message, recommendationList: recommendationList);
      }

      if (result == 200) {
        emit(
          ChatBotLoaded(
            message: isRecommendedOption
                ? ChatModel.recommendationResponse
                : ChatModel.chatBotResponse,
          ),
        );
      } else {
        emit(ChatBotError(
            error: ApiResponse.getErrorMessage(statusCode: result)));
      }
    } on Exception catch (e) {
      print('$e');
      emit(ChatBotError(error: ApiResponse.getErrorMessage(statusCode: 1000)));

      // TODO
    }
  }
}
