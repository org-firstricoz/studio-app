part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class GetChatDataEvent extends ChatEvent {
  final ChatParams chatParams;

  GetChatDataEvent({required this.chatParams});
}

class SendChatEvent extends ChatEvent {
  final ChatMessage chatMessage;

  SendChatEvent({required this.chatMessage});
}

class GetAgentDetailsEvent extends ChatEvent {
  final String agentID;

  GetAgentDetailsEvent({required this.agentID});
}
