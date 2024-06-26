// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class StudioModel {
  final String id;
  final Uint8List image;
  final String name;
  final String category;
  final String rating;
  final String location;
  final String address;
  final double rent;
  final double latitude;
  final double longitude;
  StudioModel({
    required this.id,
    required this.image,
    required this.name,
    required this.category,
    required this.rating,
    required this.location,
    required this.address,
    required this.rent,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'name': name,
      'category': category,
      'rating': rating,
      'location': location,
      'address': address,
      'rent': rent,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static empty() {
    return StudioModel(
        id: 'id',
        image: Uint8List.fromList([]),
        name: 'name',
        category: 'category',
        rating: 'rating',
        location: 'location',
        address: 'address',
        rent: 100,
        latitude: 0,
        longitude: 0);
  }

  factory StudioModel.fromMap(Map<String, dynamic> map) {
    try {
      return StudioModel(
        id: map['id'] as String,
        image: Uint8List.fromList(List<int>.from(map['image']['data'])),
        name: map['name'] as String,
        category: map['category'] as String,
        rating: map['rating'].toString(),
        location: map['location'] as String,
        address: map['address'] as String,
        rent: (map['rent'] as num).toDouble(),
        latitude: (map['latitude'] as num).toDouble(),
        longitude: (map['longitude'] as num).toDouble(),
      );
    } catch (e) {
      return StudioModel.empty();
    }
  }

  String toJson() => json.encode(toMap());

  factory StudioModel.fromJson(String source) =>
      StudioModel.fromMap(json.decode(source) as Map<String, dynamic>);

  StudioModel copyWith({
    String? id,
    Uint8List? image,
    String? name,
    String? category,
    String? rating,
    String? location,
    String? address,
    double? rent,
    double? latitude,
    double? longitude,
  }) {
    return StudioModel(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      location: location ?? this.location,
      address: address ?? this.address,
      rent: rent ?? this.rent,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  String toString() {
    return 'StudioModel(id: $id, image: $image, name: $name, category: $category, rating: $rating, location: $location, address: $address, rent: $rent, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant StudioModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.image == image &&
        other.name == name &&
        other.category == category &&
        other.rating == rating &&
        other.location == location &&
        other.address == address &&
        other.rent == rent &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        name.hashCode ^
        category.hashCode ^
        rating.hashCode ^
        location.hashCode ^
        address.hashCode ^
        rent.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
