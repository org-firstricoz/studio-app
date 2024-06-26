import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/exceptions.dart';
import 'package:flutter_riverpod_base/src/core/models/user_model.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/res/strings.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:share_plus/share_plus.dart';

abstract class SettingsDataSource {
  FutureEither<User> updateData(UpdateParams params);
  FutureEitherVoid deleteAccount();
}

int count = 0;
bool isUpdating = false;

class SettingsDataSourceImpl implements SettingsDataSource {
  final http.Client client;

  SettingsDataSourceImpl({required this.client});
  @override
  FutureEither<User> updateData(UpdateParams params) async {
    // print(params.toMap());
    try {
      isUpdating = true;
      count += 1;
      // var XphotoUrl = XFile.fromData(params.photoUrl!);
      // File.fromRawPath((await XphotoUrl.readAsBytes()));
      // final photoUrl = File(XphotoUrl.path);

      final uuid = user.uuid;

      // final response = await client.post(
      //     Uri.parse('${AppRequestUrl.baseUrl}${AppRequestUrl.update}/$uuid'),
      //     headers: {'content-type': 'application/json'},
      //     body: jsonEncode(params.toMap()));

      final request = http.MultipartRequest('POST',
          Uri.parse('${AppRequestUrl.baseUrl}${AppRequestUrl.update}/$uuid'));

      request.files.add(http.MultipartFile(
        'photoUrl',
        Stream.value(params.photoUrl!.map((e) => e).toList()),
        params.photoUrl!.length,
        filename: 'image.png',
      ));
      request.fields['email'] = params.email!;
      request.fields['gender'] = params.gender!;
      request.fields['name'] = params.name!;

      var response = await request.send();

      if (response.statusCode == 200) {
        final body = await response.stream.bytesToString();
        Hive.box('USER').put('token', body);
        final data = Jwt.parseJwt(body);
        user = User.fromMap(data);
        isUpdating = false;
        return Right(user);
      } else {
        throw ApiException(message: await response.stream.bytesToString());
      }
    } on ApiException catch (e) {
      // print(e);
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      print(e.toString());
      return Left(ApiFailure(message: e.toString().split(' ').first));
    }
  }

  @override
  FutureEitherVoid deleteAccount() async {
    try {
      final response = await client.delete(Uri.parse(
          '${AppRequestUrl.baseUrl}${AppRequestUrl.delete}/${user.uuid}'));
      if (response.statusCode == 200) {
        print('Account deleted');
        return const Right(null);
      } else {
        throw ApiException(message: response.body);
      }
    } on ApiException catch (e) {
      print(e.message);
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
