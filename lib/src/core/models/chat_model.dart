// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatMessage {
  final bool isMe;
  final String agentID;
  final String userID;
  final String message;
  final DateTime timestamp;

  ChatMessage({
    this.isMe=true,
    required this.agentID,
    required this.userID,
    required this.message,
    required this.timestamp,
  });

  static ChatMessage empty() {
    return ChatMessage(
        userID: 'sender',
        message: 'message',
        timestamp: DateTime.now(),
        agentID: 'agent');
  }

  ChatMessage copyWith({
    String? agentID,
    String? userID,
    String? message,
    DateTime? timestamp,
  }) {
    return ChatMessage(
      agentID: agentID ?? this.agentID,
      userID: userID ?? this.userID,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isMe':isMe,
      'agentID': agentID,
      'userID': userID,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      isMe: map['isMe'] as bool,
      agentID: map['agentID'].toString(),
      userID: map['userID'].toString(),
      message: map['message'].toString(),
      timestamp: DateTime.tryParse(map['timestamp'])?? DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatMessage(agentID: $agentID, userID: $userID, message: $message, timestamp: $timestamp)';
  }

  @override
  bool operator ==(covariant ChatMessage other) {
    if (identical(this, other)) return true;

    return other.agentID == agentID &&
        other.userID == userID &&
        other.message == message &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return agentID.hashCode ^
        userID.hashCode ^
        message.hashCode ^
        timestamp.hashCode;
  }
}
