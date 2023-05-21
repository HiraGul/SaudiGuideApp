import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:saudi_guide/Models/oc_model_controller.dart';
import 'package:saudi_guide/Repositories/ocr.dart';

import '../../Models/multi_string.dart';

part 'ocrcubit_state.dart';

class OcrcubitCubit extends Cubit<OcrcubitState> {
  OcrcubitCubit() : super(OcrcubitInitial());
  getOCRData({required String file}) async {
    emit(OcrcubitLoading());
    final int status = await OCRRepository.getScannedData(file: file);
    print(status);
    if (status == 200) {
      emit(OcrcubitLoaded());
      for (int i = 0; i < OCRController.ocrModel!.regions!.length; i++) {
        for (int j = 0;
            j < OCRController.ocrModel!.regions![i].lines!.length;
            j++) {
          for (int k = 0;
              k < OCRController.ocrModel!.regions![i].lines![j].words!.length;
              k++) {
            MultiLineTranslator.name = MultiLineTranslator.name +
                ' ' +
                OCRController.ocrModel!.regions![i].lines![j].words![k].text!;
            print(MultiLineTranslator.name);
          }
        }
      }
    } else if (status == 501) {
      emit(OcrcubitSocketException());
    } else {
      emit(OcrcubitException());
    }
  }
}
