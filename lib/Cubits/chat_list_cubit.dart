import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:saudi_guide/Models/chat_model.dart';


class ChatListCubit extends Cubit<List<ChatModel>> {
  ChatListCubit(super.initialState);


  getList({required List<ChatModel> list}){
    List<ChatModel> myList = List.from(list);
 myList.sort((a,b) {
      return b.dateTime.compareTo(a.dateTime);
    });
    emit(myList);
  }
}
