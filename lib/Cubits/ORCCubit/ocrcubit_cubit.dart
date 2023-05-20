import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ocrcubit_state.dart';

class OcrcubitCubit extends Cubit<OcrcubitState> {
  OcrcubitCubit() : super(OcrcubitInitial());
}
