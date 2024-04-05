// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_riverpod_base/src/core/models/agent_model.dart';

class ChatDetails {
  final AgentModel agentModel;
  final String id;
  final String time;
  final String message;
  final int unread;

  ChatDetails(
      {required this.agentModel,
      required this.id,
      required this.time,
      required this.message,
      required this.unread});

  ChatDetails copyWith(
      {String? id,
      String? name,
      String? image,
      String? time,
      String? message,
      int? unread,
      AgentModel? agentModel}) {
    return ChatDetails(
      agentModel: agentModel ?? this.agentModel,
      id: id ?? this.id,
      time: time ?? this.time,
      message: message ?? this.message,
      unread: unread ?? this.unread,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'agentModel': agentModel.toMap(),
      'time': time,
      'message': message,
      'unread': unread,
    };
  }

  factory ChatDetails.fromMap(Map<String, dynamic> map) {
    return ChatDetails(
      agentModel: AgentModel.fromMap(map['agent_details']),
      id: map['id'] as String,
      time: map['time'] as String,
      message: map['message'] as String,
      unread: map['unread'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatDetails.fromJson(String source) =>
      ChatDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatDetails(id: $id,  time: $time, message: $message, unread: $unread)';
  }

  @override
  bool operator ==(covariant ChatDetails other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.time == time &&
        other.message == message &&
        other.unread == unread;
  }

  @override
  int get hashCode {
    return id.hashCode ^ time.hashCode ^ message.hashCode ^ unread.hashCode;
  }
}
