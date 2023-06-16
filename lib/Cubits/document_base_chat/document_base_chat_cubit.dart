import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:saudi_guide/Repo/document_base_chat_repo.dart';

import '../../Models/chat_model.dart';
import '../../Repo/api_response.dart';

part 'document_base_chat_state.dart';

class DocumentBaseChatCubit extends Cubit<DocumentBaseChatState> {
  DocumentBaseChatCubit() : super(DocumentBaseChatInitial());

  getMessage(
      {dynamic message = '',
        required String userId,
      required String fileIndex}) async {
    emit(DocumentBaseChatLoading());

    try {
      // var result =
      //     await DocumentBaseChatRepo.interactWithChatBot(message: message);
      var result =
          await DocumentBaseChatRepo.getDocumentResponse(userId: userId,fileIndex: fileIndex, message: message.toString());

      if (result == 200) {
        emit(
          DocumentBaseChatLoaded(message: ChatModel.chatBotResponse),
        );
      } else {
        emit(
          DocumentBaseChatError(
            error: ApiResponse.getErrorMessage(statusCode: result),
          ),
        );
      }
    } on Exception catch (e) {
      print('$e');
      emit(DocumentBaseChatError(
          error: ApiResponse.getErrorMessage(statusCode: 1000)));

      // TODO
    }
  }
}
