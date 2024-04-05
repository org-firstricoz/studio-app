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
  FutureEither<Result> requestSchedule(RequestParams params);
}

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  final http.Client client;
  final _razorpay = Razorpay();
  ScheduleRemoteDataSourceImpl({required this.client});

  @override
  FutureEither<Result> requestSchedule(RequestParams params) async {
    // TODO: implement requestSchedule
    try {
      final response = await client.post(
          Uri.parse('${AppRequestUrl.baseUrl}${AppRequestUrl.requestEndPoint}'),
          body: jsonEncode(
            params.toMap(),
          ),
          headers: {'content-type': 'application/json'});

      if (response.statusCode == 200) {
        final orderId = response.body.toString();
        print(orderId);
        var options = {
          'key': AppSecrets.keyId,
          'amount': params.amount * 100,
          'name': params.name,
          'time_out': 240,
          "order_id": orderId,
          'prefill': {'contact': user.phoneNumber, 'email': user.email}
        };
        _razorpay.open(options);

        _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
        _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
        _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
      } else {
        throw ApiException(message: response.body);
      }
      return Left(ApiFailure(message: 'unable to make payment'));
    } on ApiException catch (e) {
      print('Error: $e');
      return Left(ApiFailure(message: e.message));
    }
  }

  @override
  // TODO: implement _razorpay
  http.Client get _client => client;

  _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    final httpResponse = await _client.post(
        Uri.parse(
          '${AppRequestUrl.baseUrl}${AppRequestUrl.payment}',
        ),
        body: jsonEncode({
          'order_id': response.orderId,
          'payment_id': response.paymentId,
          'signature': response.signature,
          'data': response.data,
        }),
        headers: {'content-type': 'application/json'});
    return Right(SuccessClass(successId: response.paymentId));
  }

  _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    return Left(
        ApiFailure(message: response.message ?? 'Unable to make payment'));
  }

  _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
}
