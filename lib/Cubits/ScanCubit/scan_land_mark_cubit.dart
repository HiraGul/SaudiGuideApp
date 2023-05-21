import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Repositories/scan.dart';

part 'scan_land_mark_state.dart';

class ScanLandMarkCubit extends Cubit<ScanLandMarkState> {
  ScanLandMarkCubit() : super(ScanLandMarkInitial());
  getScanLandMarkData({required String file}) async {
    emit(ScanLandMarkLoading());
    final int status = await ScanObjectRepository.getScannedData(file: file);
    print(status);
    if (status == 200) {
      emit(ScanLandMarkLoaded());
    } else if (status == 501) {
      emit(ScanLandMarkSocketException());
    } else {
      emit(ScanLandMarkException());
    }
  }
}
