import 'dart:convert';

import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/exceptions.dart';
import 'package:flutter_riverpod_base/src/core/models/user_model.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/res/strings.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

abstract class UpdateDataDataSource {
  FutureEither<User> updateData(UpdateParams params);
}

class UpdateDataDataSourceImpl implements UpdateDataDataSource {
  final http.Client client;

  UpdateDataDataSourceImpl({required this.client});
  @override
  FutureEither<User> updateData(UpdateParams params) async {
    print(params.toMap());
    try {
      final response = await client.post(
          Uri.parse('${AppRequestUrl.baseUrl}${AppRequestUrl.update}'),
          headers: {'content-type': 'application/json'},
          body: jsonEncode(params.toMap()));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        user = User.fromMap(data);
        return Right(user);
      } else {
        throw ApiException(message: response.body);
      }
    } on ApiException catch (e) {
      print(e);
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
