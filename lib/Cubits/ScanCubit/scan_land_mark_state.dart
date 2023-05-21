part of 'scan_land_mark_cubit.dart';

@immutable
abstract class ScanLandMarkState {}

class ScanLandMarkInitial extends ScanLandMarkState {}

class ScanLandMarkLoading extends ScanLandMarkState {}

class ScanLandMarkLoaded extends ScanLandMarkState {}

class ScanLandMarkException extends ScanLandMarkState {}

class ScanLandMarkSocketException extends ScanLandMarkState {}
