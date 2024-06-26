// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
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
  String category;
  num? rating;
  num price;
  List<String> amenities;
  FilterParams({
    required this.category,
    required this.rating,
    required this.price,
    required this.amenities,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'rating': rating,
      'price': price,
      'amenities': amenities,
    };
  }

  copyWith({
    String? category,
    num? rating,
    num? price,
    List<String>? amenities,
  }) {
    this.amenities = amenities ?? this.amenities;
    this.rating = rating ?? this.rating;
    this.price = price ?? this.price;
    this.amenities = amenities ?? this.amenities;
  }

  factory FilterParams.fromMap(Map<String, dynamic> map) {
    return FilterParams(
      category: map['category'] as String,
      rating: map['rating'] as num,
      price: map['price'] as num,
      amenities: List<String>.from((map['amenities'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterParams.fromJson(String source) =>
      FilterParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FilterParams(category: $category, rating: $rating, price: $price, amenities: $amenities)';
  }

  @override
  bool operator ==(covariant FilterParams other) {
    if (identical(this, other)) return true;

    return other.category == category &&
        other.rating == rating &&
        other.price == price &&
        listEquals(other.amenities, amenities);
  }

  @override
  int get hashCode {
    return category.hashCode ^
        rating.hashCode ^
        price.hashCode ^
        amenities.hashCode;
  }
}

class ChatParams {
  final String userId;
  final String agentId;

  ChatParams({required this.userId, required this.agentId});
}

class UpdateParams {
  final String? gender;
  final String? password;
  final String? name;
  final String? phoneNumber;
  final String? email;
  final String? location;
  final Uint8List? photoUrl;
  UpdateParams({
    this.gender,
    this.password,
    this.name,
    this.phoneNumber,
    this.email,
    this.location,
    this.photoUrl,
  });

  UpdateParams copyWith({
    String? gender,
    String? password,
    String? name,
    String? phoneNumber,
    String? email,
  }) {
    return UpdateParams(
      gender: gender ?? this.gender,
      password: password ?? this.password,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gender': gender,
      'password': password,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'location': location,
      'photoUrl': photoUrl!.buffer
    };
  }

  factory UpdateParams.fromMap(Map<String, dynamic> map) {
    return UpdateParams(
        gender: map['gender'] != null ? map['gender'] as String : null,
        password: map['password'] != null ? map['password'] as String : null,
        name: map['name'] != null ? map['name'] as String : null,
        phoneNumber:
            map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
        email: map['email'] != null ? map['email'] as String : null,
        photoUrl:
            map['photoUrl'] != null ? map['photoUrl'] as Uint8List : null);
  }

  String toJson() => json.encode(toMap());

  factory UpdateParams.fromJson(String source) =>
      UpdateParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UpdateParams(gender: $gender, password: $password, name: $name, phoneNumber: $phoneNumber, email: $email)';
  }

  @override
  bool operator ==(covariant UpdateParams other) {
    if (identical(this, other)) return true;

    return other.gender == gender &&
        other.password == password &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.email == email;
  }

  @override
  int get hashCode {
    return gender.hashCode ^
        password.hashCode ^
        name.hashCode ^
        phoneNumber.hashCode ^
        email.hashCode;
  }
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
  final DateTime createdAt;
  final String name;
  final File photoUrl;
  final String gender;
  final String phoneNumber;
  final String location;

  SignUpParams({
    required this.email,
    required this.createdAt,
    required this.name,
    required this.photoUrl,
    required this.gender,
    required this.phoneNumber,
    required this.location,
  });

  SignUpParams copyWith({
    String? email,
    DateTime? createdAt,
    String? name,
    File? photoUrl,
    String? gender,
    String? phoneNumber,
    String? location,
  }) {
    return SignUpParams(
      email: email ?? this.email,
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
      'createdAt': createdAt.millisecondsSinceEpoch,
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
      createdAt: map['createdAt'],
      name: map['name'] as String,
      photoUrl: map['photoUrl'],
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
    return 'SignUpParams(email: $email, createdAt: $createdAt, name: $name, photoUrl: $photoUrl, gender: $gender, phoneNumber: $phoneNumber, location: $location)';
  }

  @override
  bool operator ==(covariant SignUpParams other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.createdAt == createdAt &&
        other.name == name &&
        other.photoUrl == photoUrl &&
        other.gender == gender &&
        other.phoneNumber == phoneNumber &&
        other.location == location;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        createdAt.hashCode ^
        name.hashCode ^
        photoUrl.hashCode ^
        gender.hashCode ^
        phoneNumber.hashCode ^
        location.hashCode;
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
  final String uuid;
  final String studioId;
  final String? reviewId;

  ReviewParams({
    required this.review,
    required this.rating,
    required this.uuid,
    required this.studioId,
    this.reviewId,
  });

  ReviewParams copyWith({
    String? review,
    double? rating,
    String? uuid,
    String? studioId,
    String? reviewId,
  }) {
    return ReviewParams(
      review: review ?? this.review,
      rating: rating ?? this.rating,
      uuid: uuid ?? this.uuid,
      studioId: studioId ?? this.studioId,
      reviewId: reviewId ?? this.reviewId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'review': review,
      'rating': rating,
      'uuid': uuid,
      'studioId': studioId,
      'reviewId': reviewId,
    };
  }

  factory ReviewParams.fromMap(Map<String, dynamic> map) {
    return ReviewParams(
      review: map['review'] as String,
      rating: map['rating'] as double,
      uuid: map['uuid'] as String,
      studioId: map['studioId'] as String,
      reviewId: null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewParams.fromJson(String source) =>
      ReviewParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReviewParams(review: $review, rating: $rating, uuid: $uuid, studioId: $studioId, reviewId: $reviewId)';
  }

  @override
  bool operator ==(covariant ReviewParams other) {
    if (identical(this, other)) return true;

    return other.review == review &&
        other.rating == rating &&
        other.uuid == uuid &&
        other.studioId == studioId &&
        other.reviewId == reviewId;
  }

  @override
  int get hashCode {
    return review.hashCode ^
        rating.hashCode ^
        uuid.hashCode ^
        studioId.hashCode ^
        reviewId.hashCode;
  }
}
