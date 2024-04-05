import 'dart:convert';

import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/exceptions.dart';
import 'package:flutter_riverpod_base/src/core/models/agent_details.dart';
import 'package:flutter_riverpod_base/src/core/models/chat_model.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_riverpod_base/src/res/strings.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

abstract class ChatRemoteDataSource {
  final http.Client _client;

  ChatRemoteDataSource({required http.Client client}) : _client = client;
  FutureEither<List<ChatMessage>> chatService(ChatParams params);

  FutureEither<List<ChatMessage>> sendMessage(ChatMessage message);

  FutureEither<AgentDetails> getAgentDetails(String agentId);
}

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  ChatRemoteDataSourceImpl({required super.client});

  @override
  FutureEither<List<ChatMessage>> sendMessage(ChatMessage message) async {
    try {
      final response = await _client.post(
          Uri.parse('${AppRequestUrl.baseUrl}${AppRequestUrl.chat}'),
          headers: {'content-type': 'application/json'},
          body: jsonEncode(message.toMap()));
      print(response.statusCode);
      if (response.statusCode == 200) {
        AppData.chatMessages.add(message);
        print(AppData.chatMessages);
        return Right(AppData.chatMessages);
      } else {
        throw ApiException(
            message:
                'Unable to Send message, May be there\'s an error I don\'t know!!');
      }
    } on ApiException catch (e) {
      print(e);
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  FutureEither<List<ChatMessage>> chatService(ChatParams params) async {
    try {
      final response = await _client.get(Uri.parse(
          '${AppRequestUrl.baseUrl}${AppRequestUrl.chat}?uuid=${params.userId}&agentId=${params.agentId}'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final messages =
            data.map<ChatMessage>((e) => ChatMessage.fromMap(e)).toList();
        AppData.chatMessages = messages;
        return Right(messages);
      } else {
        throw ApiException(message: 'unable to Fetch messages');
      }
    } on ApiException catch (e) {
      print(e);
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      print(e.toString());
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  FutureEither<AgentDetails> getAgentDetails(String agentId) async {
    try {
      
      final response = await _client.get(Uri.parse(
          '${AppRequestUrl.baseUrl}${AppRequestUrl.agent}?agentID=$agentId'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final agentDetails = AgentDetails.fromMap(data);
        AppData.allAgentDetails = agentDetails;

        return Right(agentDetails);
      } else {
        throw ApiException(message: 'unable to get Agent data');
      }
    } on ApiException catch (e) {
      print(e);
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
