// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod_base/src/core/models/user_model.dart';
import 'package:flutter_riverpod_base/src/res/strings.dart';

class StudioDetails {
  final String id;
  final num rent;
  final String category;
  final String name;
  final double rating;
  final String address;
  final List<String> tags;
  final String description;
  final List<Uint8List> frontImage;
  final List<Uint8List> gallery;
  final num numberOfReviews;
  StudioDetails({
    required this.id,
    required this.rent,
    required this.category,
    required this.name,
    required this.rating,
    required this.address,
    required this.tags,
    required this.description,
    required this.frontImage,
    required this.gallery,
    required this.numberOfReviews,
  });

  StudioDetails copyWith({
    String? category,
    String? name,
    double? rating,
    String? address,
    List<String>? tags,
    String? description,
    List<Uint8List>? frontImage,
    List<Uint8List>? gallery,
    int? numberOfReviews,
    num? rent,
    String? id,
  }) {
    return StudioDetails(
      id: id ?? this.id,
      rent: rent ?? this.rent,
      category: category ?? this.category,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      address: address ?? this.address,
      tags: tags ?? this.tags,
      description: description ?? this.description,
      frontImage: frontImage ?? this.frontImage,
      gallery: gallery ?? this.gallery,
      numberOfReviews: numberOfReviews ?? this.numberOfReviews,
    );
  }

  static StudioDetails empty() {
    return StudioDetails(
        id: 'q2eq',
        rent: 2344,
        category: 'category',
        name: 'name',
        rating: 3.9,
        address: 'address',
        tags: ['tags'],
        description: 'description',
        frontImage: [Uint8List.fromList([]), Uint8List.fromList([])],
        gallery: [Uint8List.fromList([]), Uint8List.fromList([])],
        numberOfReviews: 200);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'name': name,
      'rating': rating,
      'address': address,
      'tags': tags,
      'description': description,
      'frontImage': frontImage,
      'gallery': gallery,
      'numberOfReviews': numberOfReviews,
      'rent': rent,
    };
  }

  factory StudioDetails.fromMap(Map<String, dynamic> map) {
    try {
      log(map['frontImage'].toString());
      return StudioDetails(
        id: map['id'].toString(),
        rent: map['rent'],
        category: map['category'] as String,
        name: map['name'] as String,
        rating: (map['rating'] as num).toDouble(),
        address: map['address'] as String,
        tags: List<String>.from(map['tags']),
        description: map['description'] as String,
        frontImage: List<Uint8List>.from(map['frontImage']
            .map((e) => Uint8List.fromList(List<int>.from(e['data'])))
            .toList()),
        gallery: List<Uint8List>.from(map['gallery']
            .map((e) => Uint8List.fromList(List<int>.from(e['data'])))
            .toList()),
        numberOfReviews: map['numberOfReviews'] as num,
      );
    } catch (e) {
      log(e.toString());
      return StudioDetails.empty();
    }
  }

  String toJson() => json.encode(toMap());

  factory StudioDetails.fromJson(String source) =>
      StudioDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StudioDetails(category: $category, name: $name, rating: $rating, address: $address, tags: $tags, description: $description, frontImage: $frontImage, gallery: $gallery, numberOfReviews: $numberOfReviews)';
  }

  @override
  bool operator ==(covariant StudioDetails other) {
    if (identical(this, other)) return true;

    return other.category == category &&
        other.name == name &&
        other.rating == rating &&
        other.address == address &&
        listEquals(other.tags, tags) &&
        other.description == description &&
        listEquals(other.frontImage, frontImage) &&
        listEquals(other.gallery, gallery) &&
        other.numberOfReviews == numberOfReviews;
  }

  @override
  int get hashCode {
    return category.hashCode ^
        name.hashCode ^
        rating.hashCode ^
        address.hashCode ^
        tags.hashCode ^
        description.hashCode ^
        frontImage.hashCode ^
        gallery.hashCode ^
        numberOfReviews.hashCode;
  }
}

class ReviewModel {
  final String name;
  final String reviewId;
  final String uuid;
  final String photoUrl;
  String review;
  num rating;
  final DateTime time;
  ReviewModel({
    required this.name,
    required this.reviewId,
    required this.uuid,
    required this.photoUrl,
    required this.review,
    required this.rating,
    required this.time,
  });

  ReviewModel copyWith({
    String? name,
    String? reviewId,
    String? uuid,
    String? photoUrl,
    String? review,
    double? rating,
    DateTime? time,
  }) {
    return ReviewModel(
      name: name ?? this.name,
      reviewId: reviewId ?? this.reviewId,
      uuid: uuid ?? this.uuid,
      photoUrl: photoUrl ?? this.photoUrl,
      review: review ?? this.review,
      rating: rating ?? this.rating,
      time: time ?? this.time,
    );
  }

  static ReviewModel empty() {
    return ReviewModel(
        name: 'name',
        reviewId: 'reviewId',
        uuid: 'uuid',
        photoUrl: 'photoUrl',
        review: 'review',
        rating: 2,
        time: DateTime.now());
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'reviewId': reviewId,
      'uuid': uuid,
      'photoUrl': photoUrl,
      'review': review,
      'rating': rating,
      'time': time.toIso8601String(),
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      name: map['name'].toString(),
      reviewId: map['reviewId'].toString(),
      uuid: map['uuid'].toString(),
      photoUrl: map['photoUrl'].toString(),
      review: map['review'].toString(),
      rating: map['rating'] as num,
      time: DateTime.parse(map['time']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReviewModel(name: $name, reviewId: $reviewId, uuid: $uuid, photoUrl: $photoUrl, review: $review, rating: $rating, time: $time)';
  }

  @override
  bool operator ==(covariant ReviewModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.reviewId == reviewId &&
        other.uuid == uuid &&
        other.photoUrl == photoUrl &&
        other.review == review &&
        other.rating == rating &&
        other.time == time;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        reviewId.hashCode ^
        uuid.hashCode ^
        photoUrl.hashCode ^
        review.hashCode ^
        rating.hashCode ^
        time.hashCode;
  }
}
