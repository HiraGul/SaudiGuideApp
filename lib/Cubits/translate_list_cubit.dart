import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saudi_guide/Models/translate_model.dart';

class TranslateListCubit extends Cubit<List<TranslateModel>> {
  TranslateListCubit() : super([]);

  addItem(model) {
    // List<TranslateModel> pre = List.from(state);
    // List<TranslateModel> newList = pre.add(model);
    // List<TranslateModel> newList = List.from(list);
    // emit(newList);
    final List<TranslateModel> updatedList = List.from(state);
    updatedList.add(model);
    List<TranslateModel> reversedList = updatedList.reversed.toList();
    emit(reversedList);
  }
}
