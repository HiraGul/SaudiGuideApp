import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class RecommendataionValidationCubit extends Cubit<int> {
  RecommendataionValidationCubit(super.initialState);


  getIndex({required int index}){
    emit(index);
  }
}
