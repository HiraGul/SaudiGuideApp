import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saudi_guide/Models/translate_model.dart';

class ChatListCubit extends Cubit<List<TranslateModel>> {
  ChatListCubit() : super([]);

  addItem(list) {
    List<TranslateModel> newList = List.from(list);
    emit(newList);
  }
}
