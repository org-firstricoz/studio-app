import 'dart:convert';

import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/exceptions.dart';
import 'package:flutter_riverpod_base/src/core/models/location_model.dart';
import 'package:flutter_riverpod_base/src/core/models/user_model.dart';
import 'package:flutter_riverpod_base/src/core/type_def.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/res/strings.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

abstract class AuthRemoteDataSource {
  AuthRemoteDataSource({required http.Client client});
  FutureEither<User> createUserWithEmailAndPassword(SignUpParams params);

  FutureEither<User> loginUserWithEmailAndPassword(LogInParams params);

  FutureEither<String> getUserLocation(NoParams params);

  FutureEither<List<LocationModel>> manualLocation(NoParams params);

  FutureEither<User> loginUsingOtp(String params);

  FutureEither<String> sendOtp(String params);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});
  @override
  FutureEither<User> createUserWithEmailAndPassword(SignUpParams params) async {
    try {
      final response = await _client.post(
          Uri.parse('${AppRequestUrl.baseUrl}${AppRequestUrl.signupEndPoint}'),
          headers: {
            'content-type': 'application/json',
          },
          body: jsonEncode(params.toMap()));
      if (response.statusCode == 200) {
        final token = response.body.toString();
        print(token);
        final decodedToken = JwtDecoder.decode(token);
        print(decodedToken);
        Hive.box('USER').put('token', token);
        final user = User.fromMap(decodedToken);

        return Right(user);
      } else {
        throw ApiException(message: response.body);
      }
    } on ApiException catch (e) {
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  FutureEither<String> getUserLocation(NoParams params) async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
      if (permission != LocationPermission.denied) {
        final result = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation);
        final placeMarks = await GeocodingPlatform.instance!
            .placemarkFromCoordinates(result.latitude, result.longitude);
        final postalCode = placeMarks.first.postalCode;
        print(postalCode);
        final resp = await Future.any([
          _client.get(
              Uri.parse('http://www.postalpincode.in/api/pincode/$postalCode')),
          Future.delayed(Duration(seconds: 5), () {
            return null;
          })
        ]);
        if (resp == null) {
          return Left(
              LocationFailure(message: 'Unable to Locate, try manually'));
        } else {
          final postOfficeResponseBody = jsonDecode(resp.body);
          if (postOfficeResponseBody['Status'] == 'Success') {
            final city = (jsonDecode(resp.body)['PostOffice'] as List)
                .first['District']
                .toString();
            print(city);
            Hive.box('USER').put("location", city);
            return Right(city);
          } else {
            throw LocationException(
                message: 'Unable to Fetch Location Try Manually');
          }
        }
      } else {
        throw LocationException(message: 'Need Location Access');
      }
    } on LocationException catch (e) {
      return Left(LocationFailure(message: e.message));
    } catch (e) {
      return Left(LocationFailure(message: e.toString()));
    }
  }

  @override
  FutureEither<User> loginUserWithEmailAndPassword(LogInParams params) async {
    print('calling login method');
    try {
      final response = await _client.post(
        Uri.parse('${AppRequestUrl.baseUrl}${AppRequestUrl.loginEndPoint}'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(params.toMap()),
      );
      final token = response.body.toString();
      print(token);
      final decodedToken = JwtDecoder.decode(token);
      print(decodedToken);
      Hive.box('USER').put('token', token);

      final user = User.fromMap(decodedToken);
      return Right(user);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  FutureEither<List<LocationModel>> manualLocation(NoParams params) async {
    try {
      final res = await _client.get(Uri.parse(
          '${AppRequestUrl.baseUrl}${AppRequestUrl.locationEndPoint}'));

      if (res.statusCode == 200) {
        final mapOfLocationData = jsonDecode(res.body) as List;
        print(mapOfLocationData);
        final listOfLocationModels =
            mapOfLocationData.map((e) => LocationModel.fromMap(e)).toList();

        print(mapOfLocationData);
        return Right(listOfLocationModels);
      } else {
        throw LocationException(message: 'Unable to Fetch Data');
      }
    } on LocationException catch (e) {
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  FutureEither<User> loginUsingOtp(String params) async {
    try {
      final response = await client.get(
        Uri.parse(
          '${AppRequestUrl.baseUrl}${AppRequestUrl.loginOtpEndPoint}?params=$params',
        ),
      );
      if (response.statusCode == 200) {
        final token = response.body.toString();
        print(token);
        final decodedToken = JwtDecoder.decode(token);
        print(decodedToken);
        Hive.box('USER').put('token', token);

        final user = User.fromMap(decodedToken);
        return Right(user);
      } else {
        throw ApiException(message: response.body);
      }
    } on ApiException catch (e) {
      return Left(ApiFailure(message: e.message));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  FutureEither<String> sendOtp(String params) async {
    // TODO: implement sendOtp
    try {
      print(params);
      final response = await client.get(Uri.parse(
          '${AppRequestUrl.baseUrl}${AppRequestUrl.otpEndPoint}?params=$params'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final otp = data["otp"];
        newUser = data["newUser"];
        return Right(otp);
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

  @override
  http.Client get _client => client;
}
