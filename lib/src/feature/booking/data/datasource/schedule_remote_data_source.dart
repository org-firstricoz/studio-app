import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod_base/secrets/secrets.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/exceptions.dart';
import 'package:flutter_riverpod_base/src/core/result.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/res/strings.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

abstract interface class ScheduleRemoteDataSource {
  final http.Client _client;

  ScheduleRemoteDataSource({required http.Client client}) : _client = client;
  FutureEither<Map<String, dynamic>> requestSchedule(RequestParams params);

  FutureEither<Map<String, dynamic>> paymentSuccess(
      Map<String, dynamic> params);
}

int? SuccessStatus;

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  final http.Client client;
  final _razorpay = Razorpay();
  ScheduleRemoteDataSourceImpl({required this.client});

  @override
  FutureEither<Map<String, dynamic>> requestSchedule(
      RequestParams params) async {
    // TODO: implement requestSchedule
    try {
      final response = await client.post(
          Uri.parse('${AppRequestUrl.baseUrl}${AppRequestUrl.requestEndPoint}'),
          body: jsonEncode(
            params.toMap(),
          ),
          headers: {'content-type': 'application/json'});
      print(response.statusCode);
      if (response.statusCode == 200) {
        final orderId = jsonDecode(response.body);
        print(orderId);
        var options = {
          'key': AppSecrets.keyId,
          'amount': params.amount * 100,
          'name': params.name,
          'time_out': 240,
          "order_id": orderId['id'],
          'prefill': {'contact': user.phoneNumber, 'email': user.email}
        };

        return Right(options);
      } else {
        throw ApiException(message: response.body);
      }
    } on ApiException catch (e) {
      print('$e');
      return Left(ApiFailure(message: e.message));
    }
  }

  @override
  // TODO: implement _razorpay
  http.Client get _client => client;

  @override
  FutureEither<Map<String, dynamic>> paymentSuccess(
      Map<String, dynamic> params) async {
    try {
      print(params);
      final response = await _client.post(
        Uri.parse(
          '${AppRequestUrl.baseUrl}${AppRequestUrl.payment}',
        ),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(params),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Right(data);
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

  // _handlePaymentSuccess(PaymentSuccessResponse response) async {
  //   // Do something when payment succeeds
  //   await _client.post(
  //       Uri.parse(
  //         '${AppRequestUrl.baseUrl}${AppRequestUrl.payment}',
  //       ),
  //       body: jsonEncode({
  //         'order_id': response.orderId,
  //         'payment_id': response.paymentId,
  //         'signature': response.signature,
  //         'data': response.data,
  //       }),
  //       headers: {'content-type': 'application/json'});
  //   SuccessStatus = 200;
  //   return Right(SuccessClass(successId: response.paymentId));
  // }
}
