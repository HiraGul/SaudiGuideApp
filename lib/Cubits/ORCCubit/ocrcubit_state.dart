part of 'ocrcubit_cubit.dart';

@immutable
abstract class OcrcubitState {}

class OcrcubitInitial extends OcrcubitState {}

class OcrcubitLoading extends OcrcubitState {}

class OcrcubitLoaded extends OcrcubitState {}

class OcrcubitSocketException extends OcrcubitState {}

class OcrcubitException extends OcrcubitState {}
