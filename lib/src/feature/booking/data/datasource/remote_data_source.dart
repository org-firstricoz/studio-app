import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/exceptions.dart';
import 'package:flutter_riverpod_base/src/core/models/agent_model.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_details.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_riverpod_base/src/res/strings.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  FutureEither<Map<String, dynamic>> getAboutSection(uid);
  FutureEither<Map<String, dynamic>> addReviewSection(ReviewParams params);
  FutureEither<Map<String, dynamic>> delteReview(String reviewId);
  FutureEither<Map<String, dynamic>> editReview(ReviewParams params);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client _client;

  RemoteDataSourceImpl({required http.Client client}) : _client = client;
  @override
  FutureEither<Map<String, dynamic>> getAboutSection(uid) async {
    try {
      final response = await _client.get(Uri.parse(
          '${AppRequestUrl.baseUrl}${AppRequestUrl.descriptionEndpoint}?uid=$uid'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final studioDetailsRemote = data['studio_details'];
        final agentDetailsRemote = data['agent_details'];
        final reviewDetailsRemote = data['review_details'];

        // print(studioDetailsRemote);
        print(agentDetailsRemote);
        // print(reviewDetailsRemote);
        final studioDetails = StudioDetails.fromMap(studioDetailsRemote);
        final agentDetails = agentDetailsRemote
            .map<AgentModel>((e) => AgentModel.fromMap(e))
            .toList();
        if (reviewDetailsRemote != [] || reviewDetailsRemote != null) {
          final reviewDetails = reviewDetailsRemote.map<ReviewModel>((e) {
            return ReviewModel.fromMap(e);
          }).toList();

          AppData.reviewModels = reviewDetails;
          AppData.studioDetails = studioDetails;
          AppData.agentDetails = agentDetails;
          return Right({
            'studio_details': studioDetails,
            'agent_details': agentDetails,
            'review_details': reviewDetails
          });
        } else {
          AppData.reviewModels = [];
          AppData.studioDetails = studioDetails;
          AppData.agentDetails = agentDetails;
          return Right({
            'studio_details': studioDetails,
            'agent_details': agentDetails,
            'review_details': []
          });
        }
      } else {
        throw ApiException(message: response.body.toString());
      }
    } on ApiException catch (e) {
      print(e.message);
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      print(e);
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  FutureEither<Map<String, dynamic>> addReviewSection(
      ReviewParams params) async {
    try {
      final response = await _client.post(
          Uri.parse('${AppRequestUrl.baseUrl}${AppRequestUrl.reviewEndPoint}'),
          headers: {'content-type': 'application/json'},
          body: jsonEncode(params.toMap()));
      log('reviewModel.toString');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final ReviewModel reviewModel = ReviewModel.fromMap(data);
        AppData.reviewModels.insert(0, reviewModel);

        return Right({'review_models': AppData.reviewModels});
      } else {
        throw ApiException(message: 'Unable to add review');
      }
    } on ApiException catch (e) {
      print(e);

      return Left(ApiFailure(message: e.message));
    } catch (e) {
      print(e);
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  FutureEither<Map<String, dynamic>> delteReview(String reviewId) async {
    try {
      final response = await _client.delete(
        Uri.parse(
            '${AppRequestUrl.baseUrl}${AppRequestUrl.reviewEndPoint}/$reviewId'),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return Right({'review_model': ReviewModel.fromMap(body)});
      } else {
        throw ApiException(message: 'Unable to Delete review');
      }
    } on ApiException catch (e) {
      print(e);

      return Left(ApiFailure(message: e.message));
    } catch (e) {
      print(e);
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  FutureEither<Map<String, dynamic>> editReview(ReviewParams params) async {
    try {
      final response = await _client.put(
          Uri.parse('${AppRequestUrl.baseUrl}${AppRequestUrl.reviewEndPoint}'),
          headers: {'content-type': 'application/json'},
          body: jsonEncode(params.toMap()));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final ReviewModel reviewModel = ReviewModel.fromMap(data);

        return Right({'review_model': reviewModel, 'edit': true});
      } else {
        throw ApiException(message: 'Unable to Edit review');
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
