// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AgentDetails {
  final String photoUrl;
  final String agentId;
  final String name;
  final String number;
  final String description;
  final List<String> media;
  final String qrData;
  AgentDetails({
    required this.photoUrl,
    required this.agentId,
    required this.name,
    required this.number,
    required this.description,
    required this.media,
    required this.qrData,
  });
  static AgentDetails empty() {
    return AgentDetails(
        photoUrl: 'photoUrl',
        agentId: 'agentId',
        name: 'name',
        number: 'number',
        description: 'description',
        media: ['media'],
        qrData: 'qrData');
  }

  AgentDetails copyWith({
    String? photoUrl,
    String? agentId,
    String? name,
    String? number,
    String? description,
    List<String>? media,
    String? qrData,
  }) {
    return AgentDetails(
      photoUrl: photoUrl ?? this.photoUrl,
      agentId: agentId ?? this.agentId,
      name: name ?? this.name,
      number: number ?? this.number,
      description: description ?? this.description,
      media: media ?? this.media,
      qrData: qrData ?? this.qrData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'photoUrl': photoUrl,
      'agentId': agentId,
      'name': name,
      'number': number,
      'description': description,
      'media': media,
      'qrData': qrData,
    };
  }

  factory AgentDetails.fromMap(Map<String, dynamic> map) {
    return AgentDetails(
      photoUrl: map['photoUrl'].toString(),
      agentId: map['agentId'].toString(),
      name: map['name'].toString(),
      number: map['number'].toString(),
      description: map['description'].toString(),
      media: List<String>.from((map['media'].toList())),
      qrData: map['qrData'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AgentDetails.fromJson(String source) =>
      AgentDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AgentDetails(photoUrl: $photoUrl, agentId: $agentId, name: $name, number: $number, description: $description, media: $media, qrData: $qrData)';
  }

  @override
  bool operator ==(covariant AgentDetails other) {
    if (identical(this, other)) return true;

    return other.photoUrl == photoUrl &&
        other.agentId == agentId &&
        other.name == name &&
        other.number == number &&
        other.description == description &&
        listEquals(other.media, media) &&
        other.qrData == qrData;
  }

  @override
  int get hashCode {
    return photoUrl.hashCode ^
        agentId.hashCode ^
        name.hashCode ^
        number.hashCode ^
        description.hashCode ^
        media.hashCode ^
        qrData.hashCode;
  }
}
