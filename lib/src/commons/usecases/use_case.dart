// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import 'package:flutter_riverpod_base/src/core/core.dart';

abstract interface class UseCase<SuccessType, Params> {
  FutureEither<SuccessType> call(Params params);
}

abstract interface class ChatUseCase<SuccessType, Params> {
  Stream<Either<Failure, SuccessType>> call(Params params);
}

// parameters

class FilterParams {
  Map<String, dynamic> toMap() {
    return {};
  }
}

class ChatParams {
  final String userId;
  final String agentId;

  ChatParams({required this.userId, required this.agentId});
}

class RequestParams {
  /* {
      'key': merchantKeyValue,
      'amount': 200,
      'name': 'Booking Studio',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': user.phoneNumber,
        'email': user.email
      },
      'external': {
        'wallets': ['paytm']
      }
    };*/

  final DateTime date;
  final TimeOfDay time;
  final String userId;
  final String studioId;
  final num amount;
  final String name;
  final String description;
  RequestParams(
      {required this.name,
      required this.description,
      required this.date,
      required this.time,
      required this.userId,
      required this.studioId,
      required this.amount});

  RequestParams copyWith(
      {DateTime? date,
      TimeOfDay? time,
      String? userId,
      String? studioId,
      num? amount,
      String? name,
      String? description}) {
    return RequestParams(
      description: description ?? this.description,
      name: name ?? this.name,
      date: date ?? this.date,
      time: time ?? this.time,
      userId: userId ?? this.userId,
      studioId: studioId ?? this.studioId,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
      'time': time.toString(),
      'userId': userId,
      'studioId': studioId,
      'amount': amount * 100,
    };
  }

  factory RequestParams.fromMap(Map<String, dynamic> map) {
    return RequestParams(
      description: map['description'],
      name: map['name'],
      date: DateTime.tryParse(map['date'].toString()) ?? DateTime.now(),
      time: TimeOfDay.fromDateTime(map['time']),
      userId: map['userId'] as String,
      studioId: map['studioId'] as String,
      amount: map['amount'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestParams.fromJson(String source) =>
      RequestParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestParams(date: $date, time: $time, userId: $userId, studioId: $studioId, amount: $amount)';
  }

  @override
  bool operator ==(covariant RequestParams other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.time == time &&
        other.userId == userId &&
        other.studioId == studioId &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        time.hashCode ^
        userId.hashCode ^
        studioId.hashCode ^
        amount.hashCode;
  }
}

class LogInParams {
  final String email;
  final String password;

  LogInParams({
    required this.email,
    required this.password,
  });

  LogInParams copyWith({
    String? email,
    String? password,
  }) {
    return LogInParams(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory LogInParams.fromMap(Map<String, dynamic> map) {
    return LogInParams(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LogInParams.fromJson(String source) =>
      LogInParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LogInParams(email: $email, password: $password)';

  @override
  bool operator ==(covariant LogInParams other) {
    if (identical(this, other)) return true;

    return other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}

class SignUpParams {
  final String email;
  final String password;
  final DateTime createdAt;
  final String name;
  final String photoUrl;
  final String gender;
  final String phoneNumber;
  final String location;

  SignUpParams({
    required this.email,
    required this.password,
    required this.name,
    required this.photoUrl,
    required this.gender,
    required this.phoneNumber,
    required this.location,
    required this.createdAt,
  });

  SignUpParams copyWith({
    String? email,
    String? password,
    DateTime? createdAt,
    String? name,
    String? photoUrl,
    String? gender,
    String? phoneNumber,
    String? location,
  }) {
    return SignUpParams(
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
      'name': name,
      'photoUrl': photoUrl,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'location': location,
    };
  }

  factory SignUpParams.fromMap(Map<String, dynamic> map) {
    return SignUpParams(
      email: map['email'] as String,
      password: map['password'] as String,
      createdAt: DateTime.now(),
      name: map['name'] as String,
      photoUrl: map['photoUrl'] as String,
      gender: map['gender'] as String,
      phoneNumber: map['phoneNumber'] as String,
      location: map['location'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpParams.fromJson(String source) =>
      SignUpParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SignUpParams(email: $email, password: $password, createdAt: $createdAt, name: $name, photoUrl: $photoUrl, gender: $gender, phoneNumber: $phoneNumber, location: $location)';
  }
}

class NoParams {}

class AllParams {
  String? uuid;
  String? location;
  String? email;
  String? password;
  DateTime? createdAt;
  String? name;
  String? photoUrl;
  String? gender;
  String? phoneNumber;
  AllParams(
      {this.uuid,
      this.location,
      this.createdAt,
      this.email,
      this.gender,
      this.name,
      this.password,
      this.phoneNumber,
      this.photoUrl});
}

class StudioParams {
  final String uid;

  StudioParams({required this.uid});
}

class ReviewParams {
  final String review;
  final double rating;
  final DateTime createdAt;
  final String uuid;

  ReviewParams({
    required this.review,
    required this.rating,
    required this.createdAt,
    required this.uuid,
  });

  ReviewParams copyWith({
    String? review,
    double? rating,
    DateTime? createdAt,
    String? uuid,
  }) {
    return ReviewParams(
      review: review ?? this.review,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      uuid: uuid ?? this.uuid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'review': review,
      'rating': rating,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'uuid': uuid,
    };
  }

  factory ReviewParams.fromMap(Map<String, dynamic> map) {
    return ReviewParams(
      review: map['review'] as String,
      rating: map['rating'] as double,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      uuid: map['uuid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewParams.fromJson(String source) =>
      ReviewParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReviewParams(review: $review, rating: $rating, createdAt: $createdAt, uuid: $uuid)';
  }

  @override
  bool operator ==(covariant ReviewParams other) {
    if (identical(this, other)) return true;

    return other.review == review &&
        other.rating == rating &&
        other.createdAt == createdAt &&
        other.uuid == uuid;
  }

  @override
  int get hashCode {
    return review.hashCode ^
        rating.hashCode ^
        createdAt.hashCode ^
        uuid.hashCode;
  }
}
