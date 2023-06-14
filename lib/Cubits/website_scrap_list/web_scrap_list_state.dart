part of 'web_scrap_list_cubit.dart';

@immutable
abstract class WebScrapListState {}

class WebScrapListInitial extends WebScrapListState {}
class WebScrapListLoading extends WebScrapListState {}
class WebScrapListLoaded extends WebScrapListState {
  final List<WebScrapListModel> list;

  WebScrapListLoaded({required this.list});
}
class WebScrapListError extends WebScrapListState {
  final String error;

  WebScrapListError({required this.error});
}
