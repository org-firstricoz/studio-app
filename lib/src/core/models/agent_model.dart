// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

class AgentModel {
  final String agentId;
  final String number;
  final String name;
  final Uint8List photoUrl;
  final String status;
  AgentModel({
    required this.agentId,
    required this.number,
    required this.name,
    required this.photoUrl,
    required this.status,
  });

  static AgentModel empty() {
    return AgentModel(
        status: 'owner',
        agentId: 'agentId',
        number: 'number',
        name: 'name',
        photoUrl: Uint8List.fromList([]));
  }

  AgentModel copyWith({
    String? agentId,
    String? number,
    String? name,
    Uint8List? photoUrl,
    String? status,
  }) {
    return AgentModel(
      agentId: agentId ?? this.agentId,
      number: number ?? this.number,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'agentId': agentId,
      'number': number,
      'name': name,
      'photoUrl': photoUrl,
      'status': status,
    };
  }

  factory AgentModel.fromMap(Map<String, dynamic> map) {
    return AgentModel(
      agentId: map['agentId'].toString(),
      number: map['number'].toString(),
      name: map['name'].toString(),
      photoUrl: Uint8List.fromList(List<int>.from(map['photoUrl']['data'])),
      status: map['status'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AgentModel.fromJson(String source) =>
      AgentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AgentModel(agentId: $agentId, number: $number, name: $name, photoUrl: $photoUrl, status: $status)';
  }

  @override
  bool operator ==(covariant AgentModel other) {
    if (identical(this, other)) return true;

    return other.agentId == agentId &&
        other.number == number &&
        other.name == name &&
        other.photoUrl == photoUrl &&
        other.status == status;
  }

  @override
  int get hashCode {
    return agentId.hashCode ^
        number.hashCode ^
        name.hashCode ^
        photoUrl.hashCode ^
        status.hashCode;
  }
}
