// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

class AgentDetails {
  final Uint8List photoUrl;
  final String agentId;
  final String name;
  final String number;
  final String description;
  final List<Uint8List> media;
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
        photoUrl: Uint8List.fromList([]),
        agentId: 'agentId',
        name: 'name',
        number: 'number',
        description: 'description',
        media: [
          Uint8List.fromList([]),
          Uint8List.fromList([]),
          Uint8List.fromList([])
        ],
        qrData: 'qrData');
  }

  AgentDetails copyWith({
    Uint8List? photoUrl,
    String? agentId,
    String? name,
    String? number,
    String? description,
    List<Uint8List>? media,
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
    print(map['media'].toString());
    try {
      return AgentDetails(
        photoUrl: Uint8List.fromList(List<int>.from(map['photoUrl']['data'])),
        agentId: map['agentId'].toString(),
        name: map['name'].toString(),
        number: map['number'].toString(),
        description: map['description'].toString(),
        media:
            //  [],
            map['media']
                .map<Uint8List>(
                    (e) => Uint8List.fromList(List<int>.from(e['data'])))
                .toList(),
        qrData: map['qrData'].toString(),
      );
    } catch (e) {
      print(e);
      return AgentDetails.empty();
    }
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
