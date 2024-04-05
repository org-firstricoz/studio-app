import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/result.dart';

abstract class ScheduleRepository {
  FutureEither<Result> requestSchedule(RequestParams params);
}
