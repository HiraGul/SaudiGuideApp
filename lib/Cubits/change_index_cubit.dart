import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeIndexCubit extends Cubit<int> {
  ChangeIndexCubit() : super(0);

  changeIndex(index) {
    emit(index);
  }
}
