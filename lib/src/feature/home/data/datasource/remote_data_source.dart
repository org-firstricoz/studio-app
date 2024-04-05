import 'dart:convert';

import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/exceptions.dart';
import 'package:flutter_riverpod_base/src/core/models/chat.dart';
import 'package:flutter_riverpod_base/src/core/models/notification.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_riverpod_base/src/res/strings.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

abstract class HomeViewRemoteDataSource {
  FutureEither<Map<String, List<StudioModel>>> getHomeViewDetails(
      AllParams params);
}

class HomeViewRemoteDataSourceImpl implements HomeViewRemoteDataSource {
  @override
  FutureEither<Map<String, List<StudioModel>>> getHomeViewDetails(
      AllParams params) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${AppRequestUrl.baseUrl}${AppRequestUrl.homeViewEndPoint}?location=${params.location}&uuid=${user.uuid}'),
      );

      var data = jsonDecode(jsonEncode(response.body));
      data = jsonDecode(data);

      final recomendedStudio = data['recommended'];
      final nearbystudio = data['nearby'];
      final category = data['categories'];
      final favorites = data['favourites'];
      final chatData = data['chatDetails'];
      final recentSearch = data['recent_search'];
      final notification = data['notification'];
      // print(category);
      // print(nearbystudio);
      // print(recomendedStudio);
      // print(favorites);
      // print(recentSearch);
      print(notification);

      final List<NotificationModel> notificationList = notification
          .map<NotificationModel>((e) => NotificationModel.fromMap(e))
          .toList();

      final List<StudioModel> recomendedStudioModels = recomendedStudio
          .map<StudioModel>((e) => StudioModel.fromMap(e))
          .toList();
      final List<StudioModel> nearbyStudios =
          nearbystudio.map<StudioModel>((e) => StudioModel.fromMap(e)).toList();
      final List<CategoryModel> categories =
          category.map<CategoryModel>((e) => CategoryModel.fromMap(e)).toList();
      final List<StudioModel> favouriteStudio =
          favorites.map<StudioModel>((e) => StudioModel.fromMap(e)).toList();
      final chatDetails =
          chatData.map<ChatDetails>((e) => ChatDetails.fromMap(e)).toList();
      final List<String> recentSearches =
          recentSearch.map<String>((e) => e.toString()).toList();

      AppData.categories = categories;
      AppData.nearByStudios = nearbyStudios;
      AppData.recomendedStudios = recomendedStudioModels;
      AppData.favouriteModel = favouriteStudio;
      AppData.chatData = chatDetails;
      AppData.recentSearches = recentSearches;
      AppData.notifications = notificationList;

      return Right({
        'recomendedStudioModels': recomendedStudioModels,
        'nearbyStudios': nearbyStudios,
        'favouriteStudios': favouriteStudio,
      });
    } on ApiException catch (e) {
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      print(e.toString());
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
