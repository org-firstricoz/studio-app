import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/models/agent_details.dart';
import 'package:flutter_riverpod_base/src/feature/chat/domain/repository/chat_repository.dart';

import 'package:flutter_riverpod_base/src/core/models/chat_model.dart';
import 'package:fpdart/fpdart.dart';

class ChatService implements UseCase<List<ChatMessage>, ChatParams> {
  final ChatRepository _chatRepository;

  ChatService({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;

  @override
  FutureEither<List<ChatMessage>> call(ChatParams params) async {
    return await _chatRepository.chatService(params);
  }
}

class SendMessage implements UseCase<List<ChatMessage>, ChatMessage> {
  final ChatRepository _chatRepository;

  SendMessage({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;

  @override
  FutureEither<List<ChatMessage>> call(ChatMessage params) async {
    return await _chatRepository.sendMessage(params);
  }
}

class GetAgentDetails implements UseCase<AgentDetails, String> {
  final ChatRepository _chatRepository;

  GetAgentDetails({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;
  @override
  FutureEither<AgentDetails> call(String params)async {
    // TODO: implement call
  return await    _chatRepository.getAgentDetails(params);
  }
}
