// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String uuid;
  final String name;
  final String email;
  final String gender;
  final String phoneNumber;
  final String photoUrl;
  final DateTime createdAt;
  final String location;
  User({
    required this.uuid,
    required this.name,
    required this.email,
    required this.gender,
    required this.phoneNumber,
    required this.photoUrl,
    required this.createdAt,
    required this.location,
  });

  User copyWith({
    String? uuid,
    String? name,
    String? email,
    String? gender,
    String? phoneNumber,
    String? photoUrl,
    DateTime? createdAt,
    String? location,
  }) {
    return User(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'name': name,
      'email': email,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'location': location,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uuid: (map['uuid'] as String).toString(),
      name: (map['name'] as String).toString(),
      email: (map['email'] as String).toString(),
      gender: (map['gender'] as String).toString(),
      phoneNumber: (map['phoneNumber'] as String).toString(),
      photoUrl: (map['photoUrl'] as String).toString(),
      createdAt: DateTime.parse((map['createdAt'])),
      location: (map['location'] as String).toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(uuid: $uuid, name: $name, email: $email, gender: $gender, phoneNumber: $phoneNumber, photoUrl: $photoUrl, createdAt: $createdAt, location: $location)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.uuid == uuid &&
        other.name == name &&
        other.email == email &&
        other.gender == gender &&
        other.phoneNumber == phoneNumber &&
        other.photoUrl == photoUrl &&
        other.createdAt == createdAt &&
        other.location == location;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        gender.hashCode ^
        phoneNumber.hashCode ^
        photoUrl.hashCode ^
        createdAt.hashCode ^
        location.hashCode;
  }

  static User empty() {
    return User(
        uuid: 'uuid',
        name: 'name',
        email: 'email',
        gender: 'gender',
        phoneNumber: '1234567890',
        photoUrl: 'photoUrl',
        createdAt: DateTime.now(),
        location: 'location');
  }
}
