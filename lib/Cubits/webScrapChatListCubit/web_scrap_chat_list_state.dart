abstract class WebScrapChatListState {}

class WebScrapChatListInitial extends WebScrapChatListState {}

class WebScrapChatListLoading extends WebScrapChatListState {}

class WebScrapChatListLoaded extends WebScrapChatListState {
  final String message;

  WebScrapChatListLoaded({required this.message});
}

class WebScrapChatListError extends WebScrapChatListState {
  final String error;

  WebScrapChatListError({required this.error});
}
