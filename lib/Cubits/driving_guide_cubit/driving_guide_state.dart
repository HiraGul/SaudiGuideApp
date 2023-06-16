part of 'driving_guide_cubit.dart';

@immutable
abstract class DrivingGuideState {}

class DrivingGuideInitial extends DrivingGuideState {}
class DrivingGuideEmpty extends DrivingGuideState {}
class DrivingGuideLoading extends DrivingGuideState {}
class DrivingGuideLoaded extends DrivingGuideState {

  final UserDocumentModel model;

  DrivingGuideLoaded({required this.model});
}
class DrivingGuideError extends DrivingGuideState {
  final String error;

  DrivingGuideError({required this.error});
}
