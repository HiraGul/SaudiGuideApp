import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saudi_guide/Cubits/webScrapChatListCubit/web_scrap_chat_list_state.dart';
import 'package:saudi_guide/Models/chat_model.dart';
import 'package:saudi_guide/Repo/web_scrap_chat_list_repo.dart';

class WebScrapChatListCubit extends Cubit<WebScrapChatListState> {
  WebScrapChatListCubit() : super(WebScrapChatListInitial());

  StreamSubscription? firebaseStream;

  getData(String docId, String message, String userId) async {
    try {
      emit(WebScrapChatListLoading());
      var data = await WebScrapChatListRepo.getScrap(
          id: docId, message: message, userId: userId);

      if (data == 200) {
        emit(WebScrapChatListLoaded(message: ChatModel.webScrapMessage));
      } else if (data == 400) {
        emit(WebScrapChatListError(error: "Bad Request"));
      }
    } on Exception catch (e) {
      emit(
        WebScrapChatListError(
          error: e.toString(),
        ),
      );
      // TODO
    }
  }
}
