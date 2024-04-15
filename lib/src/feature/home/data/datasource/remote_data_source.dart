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
  FutureEitherVoid saveFavourites(List<StudioModel> params);
}

class HomeViewRemoteDataSourceImpl implements HomeViewRemoteDataSource {
  @override
  FutureEither<Map<String, List<StudioModel>>> getHomeViewDetails(
      AllParams params) async {
    try {
      print('hi');
      final response = await http.get(
        Uri.parse(
            '${AppRequestUrl.baseUrl}${AppRequestUrl.homeViewEndPoint}?location=${params.location}&uuid=${user.uuid}'),
      );

      var data = jsonDecode(jsonEncode(response.body));
      data = jsonDecode(data);
      print(data);
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
      // print(notification);

      final List<StudioModel> recomendedStudioModels =
          (recomendedStudio as List).isNotEmpty
              ? recomendedStudio
                  .map<StudioModel>((e) => StudioModel.fromMap(e))
                  .toList()
              : [];
      final List<StudioModel> nearbyStudios = (nearbystudio as List).isNotEmpty
          ? nearbystudio
              .map<StudioModel>((e) => StudioModel.fromMap(e))
              .toList()
          : [];
      final List<CategoryModel> categories = (category as List).isNotEmpty
          ? category
              .map<CategoryModel>((e) => CategoryModel.fromMap(e))
              .toList()
          : [];
      final List<StudioModel> favouriteStudio = (favorites as List).isNotEmpty
          ? favorites.map<StudioModel>((e) => StudioModel.fromMap(e)).toList()
          : [];
      final List<ChatDetails> chatDetails = (chatData as List).isNotEmpty
          ? chatData.map<ChatDetails>((e) => ChatDetails.fromMap(e)).toList()
          : [];
      final List<String> recentSearches = (recentSearch as List).isNotEmpty
          ? recentSearch.map<String>((e) => e.toString()).toList()
          : [];
      final List<NotificationModel> notificationList =
          (notification as List).isNotEmpty
              ? notification
                  .map<NotificationModel>((e) => NotificationModel.fromMap(e))
                  .toList()
              : [];

      AppData.nearByStudios = nearbyStudios;
      AppData.recomendedStudios = recomendedStudioModels;
      AppData.categories = categories;
      AppData.favouriteModel = favouriteStudio;
      AppData.chatData = chatDetails;
      AppData.recentSearches = recentSearches;
      AppData.notifications = notificationList;
      print(AppData.nearByStudios);
      return Right({
        'recomendedStudioModels': recomendedStudioModels,
        'nearbyStudios': nearbyStudios,
        'favouriteStudios': favouriteStudio,
      });
    } on ApiException catch (e) {
      print(e.message);
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      print(e.toString());
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  FutureEitherVoid saveFavourites(List<StudioModel> params) async {
    try {
      final response = await http.put(
          Uri.parse('${AppRequestUrl.baseUrl}${AppRequestUrl.favourites}'),
          headers: {'content-type': 'application/json'},
          body: jsonEncode({
            'uuid': user.uuid,
            'studio_id': params.map((e) => e.id).toList()
          }));
      if (response.statusCode == 200) {
        jsonDecode(response.body);
        print("done");
        return const Right(null);
      } else {
        throw ApiException(message: response.body);
      }
    } on ApiException catch (e) {
      print(e);
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      print(e);
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
