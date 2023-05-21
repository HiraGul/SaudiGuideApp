import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:saudi_guide/Repositories/ocr.dart';

part 'ocrcubit_state.dart';

class OcrcubitCubit extends Cubit<OcrcubitState> {
  OcrcubitCubit() : super(OcrcubitInitial());
  getOCRData({required String file}) async {
    emit(OcrcubitLoading());
    final int status = await OCRRepository.getScannedData(file: file);
    print(status);
    if (status == 200) {
      emit(OcrcubitLoaded());
    } else if (status == 501) {
      emit(OcrcubitSocketException());
    } else {
      emit(OcrcubitException());
    }
  }
}
