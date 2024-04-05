part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class LoadingState extends ChatState {}

class ChatSuccessState extends ChatState {
  final List<ChatMessage> messages;

  ChatSuccessState({required this.messages});
}

class ChatFailureState extends ChatState {
  final String message;

  ChatFailureState({required this.message});
}

class SendChatSuccessState extends ChatState {
  final ChatMessage message;

  SendChatSuccessState({required this.message});
}

class AgentDetailsSuccessState extends ChatState {
  final AgentDetails agentDetails;

  AgentDetailsSuccessState({required this.agentDetails});
}
