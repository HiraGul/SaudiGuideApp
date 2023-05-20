part of 'my_recomendation_cubit.dart';

@immutable
abstract class MyRecomendationState {}

class MyRecommendationInitial extends MyRecomendationState {}
class MyRecommendationLoading extends MyRecomendationState {}
class MyRecommendationLoaded extends MyRecomendationState {
  final String message;

  MyRecommendationLoaded({required this.message});
}
class MyRecommendationError extends MyRecomendationState {
  final String error;

  MyRecommendationError({required this.error});
}
