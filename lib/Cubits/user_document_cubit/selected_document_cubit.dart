import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class SelectedDocumentCubit extends Cubit<int> {
  SelectedDocumentCubit(super.initialState);


  getSelectedDocument({required int index})async{
    emit(index);
  }
}
