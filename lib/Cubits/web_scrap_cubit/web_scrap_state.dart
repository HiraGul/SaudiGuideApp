part of 'web_scrap_cubit.dart';

@immutable
abstract class WebScrapState {}

class WebScrapInitial extends WebScrapState {}
class WebScrapLoading extends WebScrapState {}
class WebScrapLoaded extends WebScrapState {}
class WebScrapError extends WebScrapState {
  final String error;

  WebScrapError({required this.error});
}
