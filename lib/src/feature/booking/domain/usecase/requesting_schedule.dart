import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/result.dart';
import 'package:flutter_riverpod_base/src/core/type_def.dart';
import 'package:flutter_riverpod_base/src/feature/booking/domain/repository/schedule_repository.dart';

class RequestingSchedule
    implements UseCase<Map<String, dynamic>, RequestParams> {
  final ScheduleRepository _scheduleRepository;

  RequestingSchedule({required ScheduleRepository scheduleRepository})
      : _scheduleRepository = scheduleRepository;
  @override
  FutureEither<Map<String, dynamic>> call(params) async {
    // TODO: implement call
    return await _scheduleRepository.requestSchedule(params);
  }
}

class SendingData implements UseCase<Map<String, dynamic>, Map<String, dynamic>> {
  final ScheduleRepository _scheduleRepository;

  SendingData({required ScheduleRepository scheduleRepository})
      : _scheduleRepository = scheduleRepository;
  @override
  FutureEither<Map<String, dynamic>> call(Map<String, dynamic> params) {
    // TODO: implement call
    return _scheduleRepository.paymentSuccess(params);
  }
}
