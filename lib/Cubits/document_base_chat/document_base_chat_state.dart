part of 'document_base_chat_cubit.dart';

@immutable
abstract class DocumentBaseChatState {}

class DocumentBaseChatInitial extends DocumentBaseChatState {}
class DocumentBaseChatLoading extends DocumentBaseChatState {}
class DocumentBaseChatLoaded extends DocumentBaseChatState {

  final String message;

  DocumentBaseChatLoaded({required this.message});
}
class DocumentBaseChatError extends DocumentBaseChatState {
  final String error;

  DocumentBaseChatError({required this.error});
}
