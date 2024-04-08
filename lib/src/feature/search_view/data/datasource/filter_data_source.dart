import 'dart:convert';

import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/exceptions.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_riverpod_base/src/res/strings.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

abstract interface class FilterDataSource {
  FutureEither<List<StudioModel>> getFilteredResults(FilterParams params);
}

class FilterDataSourceImpl implements FilterDataSource {
  final http.Client _client;

  FilterDataSourceImpl({required http.Client client}) : _client = client;
  @override
  FutureEither<List<StudioModel>> getFilteredResults(
      FilterParams params) async {
    try {
      final response = await _client.post(
          Uri.parse('${AppRequestUrl.baseUrl}${AppRequestUrl.filter}'),
          headers: {'content-type': 'application/json'},
          body: jsonEncode(params.toMap()));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        final List<StudioModel> filterResult =
            data.map<StudioModel>((e) => StudioModel.fromMap(e)).toList();

        AppData.filterResult = filterResult;
        return Right(AppData.filterResult);
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
}
