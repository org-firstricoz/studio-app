// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_riverpod_base/src/core/models/agent_details.dart';
import 'package:flutter_riverpod_base/src/core/models/agent_model.dart';
import 'package:flutter_riverpod_base/src/core/models/chat.dart';
import 'package:flutter_riverpod_base/src/core/models/notification.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_details.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/core/models/chat_model.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';

class AppData {
 

  static List<NotificationModel> notifications = [
    NotificationModel(
      title: 'Tour Booked Successfully',
      message:
          'we’re Checking if the Studio can be seen on .we’re Checking if the Studio can be seen on.',
      type: NotificationType.tourBooked,
      date: DateTime.now(),
    ),
    NotificationModel(
      title: 'Exclusive Offers Inside',
      message:
          'we’re Checking if the Studio can be seen on .we’re Checking if the Studio can be seen on.',
      type: NotificationType.exclusiveOffer,
      date: DateTime.now(),
    ),
    NotificationModel(
      title: 'Exclusive Offer',
      message:
          'we’re Checking if the Studio can be seen on .we’re Checking if the Studio can be seen on.',
      type: NotificationType.reviewRequest,
      date: DateTime.now(),
    ),
    NotificationModel(
      title: 'Tour Booked Accepted',
      message:
          'we’re Checking if the Studio can be seen on .we’re Checking if the Studio can be seen on.',
      type: NotificationType.reviewRequest,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    NotificationModel(
      title: 'Exclusive Offers Inside',
      message:
          'we’re Checking if the Studio can be seen on .we’re Checking if the Studio can be seen on.',
      type: NotificationType.exclusiveOffer,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    NotificationModel(
      title: 'New Studio Nearby You',
      message:
          'we’re Checking if the Studio can be seen on .we’re Checking if the Studio can be seen on.',
      type: NotificationType.alert,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    NotificationModel(
      title: 'Exclusive Offers Inside',
      message:
          'we’re Checking if the Studio can be seen on .we\'re Checking if the Studio can be seen on.',
      type: NotificationType.exclusiveOffer,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  static List<CategoryModel> categories = [
    CategoryModel(image: ImageAssets.photgraphy, title: "PhotoGraphy"),
    CategoryModel(image: ImageAssets.art, title: "Art"),
    CategoryModel(image: ImageAssets.music, title: "Music"),
    CategoryModel(image: ImageAssets.dance, title: "Dance")
  ];
  static List<StudioModel> recomendedStudios = [
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        title: "Harmony Studios",
        image: ImageAssets.studio1,
        tag: "Photography",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 1500),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        title: "The Dancextream",
        image: ImageAssets.studio2,
        tag: "Artistic Haven",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 900),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        title: "Art Studios",
        image: ImageAssets.studio3,
        tag: "Music",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 1500),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        title: "Photo Studios",
        image: ImageAssets.studio4,
        tag: "Art",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 1200),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        title: "Harmony Studios",
        image: ImageAssets.studio5,
        tag: "Musci",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 2000),
  ];
  static List<StudioModel> favouriteModel = [
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        title: "Harmony Studios",
        image: ImageAssets.studio1,
        tag: "Photography",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 1500),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        title: "The Dancextream",
        image: ImageAssets.studio2,
        tag: "Artistic Haven",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 900),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        title: "Art Studios",
        image: ImageAssets.studio3,
        tag: "Music",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 1500),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        title: "Photo Studios",
        image: ImageAssets.studio4,
        tag: "Art",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 1200),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        title: "Harmony Studios",
        image: ImageAssets.studio5,
        tag: "Musci",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 2000),
  ];

  static List<StudioModel> nearByStudios = [
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        title: "Harmony Studios",
        image: ImageAssets.studio1,
        tag: "Photography",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 1500),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        title: "The Dancextream",
        image: ImageAssets.studio2,
        tag: "Artistic Haven",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 900),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        title: "Art Studios",
        image: ImageAssets.studio3,
        tag: "Music",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 1500),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        title: "Photo Studios",
        image: ImageAssets.studio4,
        tag: "Art",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 1200),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        title: "Harmony Studios",
        image: ImageAssets.studio5,
        tag: "Musci",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 2000),
  ];

  static List<ChatDetails> chatData = [
    ChatDetails(
        id: '12',
        agentModel: AgentModel.empty(),
        time: '09:34 PM',
        message: 'Hey, how are you doing?',
        unread: 2),
    ChatDetails(
        id: '12',
        agentModel: AgentModel.empty(),
        time: '09:34 PM',
        message: 'I am doing great, thanks for asking. How about you?',
        unread: 0),
    ChatDetails(
        id: '12',
        agentModel: AgentModel.empty(),
        time: '09:34 PM',
        message:
            'I am doing well too, thanks. What have you been up to lately?',
        unread: 1),
    ChatDetails(
        id: '12',
        agentModel: AgentModel.empty(),
        time: '09:34 PM',
        message: 'Not much, just working on some projects. How about you?',
        unread: 0),
    ChatDetails(
        id: '12',
        agentModel: AgentModel.empty(),
        time: '09:34 PM',
        message: 'Same here, just trying to stay productive. Have a good day!',
        unread: 0)
  ];

  static List<ReviewModel> reviewModels = [
    ReviewModel(
        reviewId: '3',
        name: "Dale Thiel",
        photoUrl: ImageAssets.profileImageJpeg,
        review:
            "Discover our state-of-the-art Photography Studio, a haven for photographers and creatives a like. ",
        rating: 4.0,
        time: DateTime.now()),
    ReviewModel(
        reviewId: '2',
        name: "John Doe",
        photoUrl: ImageAssets.profileImageJpeg,
        review:
            "Discover our state-of-the-art Photography Studio, a haven for photographers and creatives a like. ",
        rating: 4.0,
        time: DateTime.now()),
    ReviewModel(
        reviewId: '1',
        name: "John Doe",
        photoUrl: '',
        review:
            "Discover our state-of-the-art Photography Studio, a haven for photographers and creatives a like. ",
        rating: 4.0,
        time: DateTime.now()),
  ];

  static StudioDetails studioDetails = StudioDetails.empty();

  static List<AgentModel> agentDetails = [
    AgentModel.empty(),
    AgentModel.empty()
  ];

  static AgentDetails allAgentDetails = AgentDetails.empty();

  static List<StudioModel> searchResult = [];

  static List<String> recentSearches = [];

  static List<ChatMessage> chatMessages = [];

  static List<StudioModel> filterResult = [];
}

class CategoryModel {
  final String image;
  final String title;
  CategoryModel({
    required this.image,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'title': title,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      image: map['image'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
