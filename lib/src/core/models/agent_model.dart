// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AgentModel {
  final String id;
  final String number;
  final String name;
  final String imageUrl;
  final String status;
  AgentModel({
    required this.id,
    required this.number,
    required this.name,
    required this.imageUrl,
    required this.status,
  });

  static AgentModel empty() {
    return AgentModel(
        status: 'owner',
        id: 'id',
        number: 'number',
        name: 'name',
        imageUrl: 'imageUrl');
  }

  AgentModel copyWith({
    String? id,
    String? number,
    String? name,
    String? imageUrl,
    String? status,
  }) {
    return AgentModel(
      id: id ?? this.id,
      number: number ?? this.number,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'number': number,
      'name': name,
      'imageUrl': imageUrl,
      'status': status,
    };
  }

  factory AgentModel.fromMap(Map<String, dynamic> map) {
    return AgentModel(
      id: map['id'] as String,
      number: map['number'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AgentModel.fromJson(String source) =>
      AgentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AgentModel(id: $id, number: $number, name: $name, imageUrl: $imageUrl, status: $status)';
  }

  @override
  bool operator ==(covariant AgentModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.number == number &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        number.hashCode ^
        name.hashCode ^
        imageUrl.hashCode ^
        status.hashCode;
  }
}
