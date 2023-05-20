part of 'chat_bot_cubit.dart';

@immutable
abstract class ChatBotState {}

class ChatBotInitial extends ChatBotState {}
class ChatBotLoading extends ChatBotState {}
class ChatBotLoaded extends ChatBotState {
  final String message;

  ChatBotLoaded({required this.message});
}
class ChatBotError extends ChatBotState {
  final String error;

  ChatBotError({required this.error});
}
