// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatMessage {
  final String id;
  final bool isMe;
  final String agentID;
  final String uuid;
  final String message;
  final DateTime timestamp;

  ChatMessage( {required this.id,
    this.isMe = true,
    required this.agentID,
    required this.uuid,
    required this.message,
    required this.timestamp,
  });

  static ChatMessage empty() {
    return ChatMessage(
      id:'id',
        uuid: 'sender',
        message: 'message',
        timestamp: DateTime.now(),
        agentID: 'agent');
  }

  ChatMessage copyWith({
    String? agentID,
    String? uuid,
    String? message,
    DateTime? timestamp,
    String? id
  }) {
    return ChatMessage(
      id: id??this.id,
      agentID: agentID ?? this.agentID,
      uuid: uuid ?? this.uuid,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isMe': isMe,
      'agentID': agentID,
      'uuid': uuid,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'id':id,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id:map['id'] as String,
      isMe: map['isMe'] as bool,
      agentID: map['agentID'].toString(),
      uuid: map['uuid'].toString(),
      message: map['message'].toString(),
      timestamp: DateTime.tryParse(map['timestamp']) ?? DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatMessage(agentID: $agentID, uuid: $uuid, message: $message, timestamp: $timestamp)';
  }

  @override
  bool operator ==(covariant ChatMessage other) {
    if (identical(this, other)) return true;

    return other.agentID == agentID &&
        other.uuid == uuid &&
        other.message == message &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return agentID.hashCode ^
        uuid.hashCode ^
        message.hashCode ^
        timestamp.hashCode;
  }
}
