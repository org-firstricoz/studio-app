import 'dart:convert';

import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/commons/views/help-center/data/model/faq_model.dart';
import 'package:flutter_riverpod_base/src/commons/views/help-center/presentation/pages/faq_tab.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/exceptions.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_riverpod_base/src/res/strings.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

abstract class HelpCenterRemoteDataSource {
  FutureEither<List<CustomExpadedTile>> getHelpData(String params);
}

class HelpCenterRemoteDataSourceImpl implements HelpCenterRemoteDataSource {
  final http.Client _client;

  HelpCenterRemoteDataSourceImpl({required http.Client client})
      : _client = client;
  @override
  FutureEither<List<CustomExpadedTile>> getHelpData(String params) async {
    try {
      final uri = '${AppRequestUrl.baseUrl}${AppRequestUrl.help}/$params';
      print(uri);
      final response = await _client.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as List;
        final List<FAQDataModel> data =
            body.map<FAQDataModel>((e) => FAQDataModel.fromMap(e)).toList();
        final List<CustomExpadedTile> finalData = data
            .map<CustomExpadedTile>((e) =>
                CustomExpadedTile(title: e.title, description: e.description))
            .toList();
        AppData.helpScetion = finalData;
        return Right(finalData);
      } else {
        throw ApiException(message: response.body);
      }
    } on ApiException catch (e) {
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
