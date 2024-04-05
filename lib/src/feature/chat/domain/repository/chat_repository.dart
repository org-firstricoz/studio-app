import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/models/agent_details.dart';
import 'package:flutter_riverpod_base/src/core/models/chat_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class ChatRepository {
  FutureEither<List<ChatMessage>> chatService(ChatParams params);

  FutureEither<List<ChatMessage>> sendMessage(ChatMessage message);

  FutureEither<AgentDetails> getAgentDetails(String uid);
}
