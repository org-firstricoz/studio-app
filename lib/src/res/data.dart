// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod_base/src/commons/views/help-center/presentation/pages/faq_tab.dart';
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
        name: "Harmony Studios",
        image: Uint8List.fromList([]),
        category: "Photography",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 1500),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        name: "The Dancextream",
        image: Uint8List.fromList([]),
        category: "Artistic Haven",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 900),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        name: "Art Studios",
        image: Uint8List.fromList([]),
        category: "Music",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 1500),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        name: "Photo Studios",
        image: Uint8List.fromList([]),
        category: "Art",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 1200),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        name: "Harmony Studios",
        image: Uint8List.fromList([]),
        category: "Musci",
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
        name: "Harmony Studios",
        image: Uint8List.fromList([]),
        category: "Photography",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 1500),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        name: "The Dancextream",
        image: Uint8List.fromList([]),
        category: "Artistic Haven",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 900),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        name: "Art Studios",
        image: Uint8List.fromList([]),
        category: "Music",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 1500),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        name: "Photo Studios",
        image: Uint8List.fromList([]),
        category: "Art",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 1200),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        name: "Harmony Studios",
        image: Uint8List.fromList([]),
        category: "Musci",
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
        name: "Harmony Studios",
        image: Uint8List.fromList([]),
        category: "Photography",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 1500),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        name: "The Dancextream",
        image: Uint8List.fromList([]),
        category: "Artistic Haven",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 900),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        name: "Art Studios",
        image: Uint8List.fromList([]),
        category: "Music",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 1500),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        name: "Photo Studios",
        image: Uint8List.fromList([]),
        category: "Art",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 1200),
    StudioModel(
        latitude: 0,
        longitude: 0,
        address: 'xyz street , JamNagar, Gujarat',
        id: '1',
        name: "Harmony Studios",
        image: Uint8List.fromList([]),
        category: "Musci",
        rating: '4.8',
        location: "Pune, Maharastra",
        rent: 2000),
  ];

  static List<ChatEntity> chatData = [];

  static List<ReviewModel> reviewModels = [
    ReviewModel(
        uuid: '1',
        reviewId: '3',
        name: "Dale Thiel",
        photoUrl: ImageAssets.profileImageJpeg,
        review:
            "Discover our state-of-the-art Photography Studio, a haven for photographers and creatives a like. ",
        rating: 4.0,
        time: DateTime.now()),
    ReviewModel(
        uuid: '1',
        reviewId: '2',
        name: "John Doe",
        photoUrl: ImageAssets.profileImageJpeg,
        review:
            "Discover our state-of-the-art Photography Studio, a haven for photographers and creatives a like. ",
        rating: 4.0,
        time: DateTime.now()),
    ReviewModel(
        uuid: '1',
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

  static List<CustomExpadedTile> helpScetion = [
    const CustomExpadedTile(
        title: "How do i schedule a Tour?",
        description:
            "Welcome to the \"Studio on Rent\" app, created to help users find and book studio spaces. Your privacy is important to us, and we are committed "),
    const CustomExpadedTile(
        title: "How do i schedule a Tour?",
        description:
            "Welcome to the \"Studio on Rent\" app, created to help users find and book studio spaces. Your privacy is important to us, and we are committed "),
    const CustomExpadedTile(
        title: "How do i schedule a Tour?",
        description:
            "Welcome to the \"Studio on Rent\" app, created to help users find and book studio spaces. Your privacy is important to us, and we are committed "),
    const CustomExpadedTile(
        title: "How do i schedule a Tour?",
        description:
            "Welcome to the \"Studio on Rent\" app, created to help users find and book studio spaces. Your privacy is important to us, and we are committed "),
    const CustomExpadedTile(
        title: "How do i schedule a Tour?",
        description:
            "Welcome to the \"Studio on Rent\" app, created to help users find and book studio spaces. Your privacy is important to us, and we are committed "),
    const CustomExpadedTile(
        title: "How do i schedule a Tour?",
        description:
            "Welcome to the \"Studio on Rent\" app, created to help users find and book studio spaces. Your privacy is important to us, and we are committed ")
  ];
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
