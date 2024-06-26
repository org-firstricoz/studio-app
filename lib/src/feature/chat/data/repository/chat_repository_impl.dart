import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/failure.dart';
import 'package:flutter_riverpod_base/src/core/models/agent_details.dart';

import 'package:flutter_riverpod_base/src/core/models/chat_model.dart';
import 'package:flutter_riverpod_base/src/feature/chat/data/datasource/chat_remote_data_source.dart';
import 'package:flutter_riverpod_base/src/feature/chat/domain/repository/chat_repository.dart';
import 'package:fpdart/src/either.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _chatRemoteDataSource;

  ChatRepositoryImpl({required ChatRemoteDataSource chatRemoteDataSource})
      : _chatRemoteDataSource = chatRemoteDataSource;
  @override
  FutureEither<List<ChatMessage>> chatService(ChatParams params) async {
    return await _chatRemoteDataSource.chatService(params);
  }

  @override
  FutureEither<List<ChatMessage>> sendMessage(ChatMessage message) async {
    return await _chatRemoteDataSource.sendMessage(message);
  }

  @override
  FutureEither<AgentDetails> getAgentDetails(String uid) async {
    // TODO: implement getAgentDetails
    return await _chatRemoteDataSource.getAgentDetails(uid);
  }
}
