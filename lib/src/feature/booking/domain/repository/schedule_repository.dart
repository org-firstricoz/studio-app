import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/result.dart';

abstract class ScheduleRepository {
  FutureEither<Map<String, dynamic>> requestSchedule(RequestParams params);
  FutureEither<Map<String, dynamic>> paymentSuccess(Map<String, dynamic> params);
}
