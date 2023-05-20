import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'scan_land_mark_state.dart';

class ScanLandMarkCubit extends Cubit<ScanLandMarkState> {
  ScanLandMarkCubit() : super(ScanLandMarkInitial());
}
