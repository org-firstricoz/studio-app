// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ChatEntity {
  final String name;
  final Uint8List photoUrl;
  final DateTime time;
  final String id;
  final String userId;
  final String agentId;
  ChatEntity({
    required this.name,
    required this.photoUrl,
    required this.time,
    required this.id,
    required this.userId,
    required this.agentId,
  });

  ChatEntity copyWith({
    String? name,
    Uint8List? photoUrl,
    DateTime? time,
    String? id,
    String? userId,
    String? agentId,
  }) {
    return ChatEntity(
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      time: time ?? this.time,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      agentId: agentId ?? this.agentId,
    );
  }

  static empty() {
    return ChatEntity(
        name: 'name',
        photoUrl: Uint8List.fromList([]),
        time: DateTime.now(),
        id: 'id',
        userId: 'userId',
        agentId: 'agentId');
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'photoUrl': photoUrl.buffer,
      'time': time.toString(),
      'id': id,
      'userId': userId,
      'agentId': agentId,
    };
  }

  factory ChatEntity.fromMap(Map<String, dynamic> map) {
    try {
      return ChatEntity(
        name: map['name'] as String,
        photoUrl: Uint8List.fromList(map['photoUrl']),
        time: DateTime.parse(map['time'].toString()),
        id: map['id'] as String,
        userId: map['userId'] as String,
        agentId: map['agentId'] as String,
      );
    } catch (e) {
      print(e);
      return ChatEntity.empty();
    }
  }

  String toJson() => json.encode(toMap());

  factory ChatEntity.fromJson(String source) =>
      ChatEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatEntity(name: $name, photoUrl: $photoUrl, time: $time, id: $id, userId: $userId, agentId: $agentId)';
  }

  @override
  bool operator ==(covariant ChatEntity other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.photoUrl == photoUrl &&
        other.time == time &&
        other.id == id &&
        other.userId == userId &&
        other.agentId == agentId;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        photoUrl.hashCode ^
        time.hashCode ^
        id.hashCode ^
        userId.hashCode ^
        agentId.hashCode;
  }
}
