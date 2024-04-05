import 'dart:convert';

import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/exceptions.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/core/type_def.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_riverpod_base/src/res/strings.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

abstract class SearchViewRemoteDataSource {
  final http.Client _client;

  SearchViewRemoteDataSource({required http.Client client}) : _client = client;
  FutureEither<Map<String, dynamic>> getSearchResults(String query);
}

class SearchViewRemoteDataSourceImpl implements SearchViewRemoteDataSource {
  final http.Client client;

  SearchViewRemoteDataSourceImpl({required this.client});
  @override
  FutureEither<Map<String, dynamic>> getSearchResults(String query) async {
    try {
      final response = await client.get(Uri.parse(
          '${AppRequestUrl.baseUrl}${AppRequestUrl.search}?search=$query'));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        final List<StudioModel> searchResult =
            data.map<StudioModel>((e) => StudioModel.fromMap(e)).toList();

        AppData.searchResult = searchResult;
        return Right({'search_result': searchResult});
      } else {
        throw ApiException(message: 'No Studio Found');
      }
    } on ApiException catch (e) {
      print(e);
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  http.Client get _client => client;
}
