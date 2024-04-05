import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/result.dart';
import 'package:flutter_riverpod_base/src/core/type_def.dart';
import 'package:flutter_riverpod_base/src/feature/booking/data/datasource/schedule_remote_data_source.dart';
import 'package:flutter_riverpod_base/src/feature/booking/domain/repository/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource _scheduleRemoteDataSource;

  ScheduleRepositoryImpl(
      {required ScheduleRemoteDataSource scheduleRemoteDataSource})
      : _scheduleRemoteDataSource = scheduleRemoteDataSource;
  @override
  FutureEither<Result> requestSchedule(RequestParams params) async{
    return await _scheduleRemoteDataSource.requestSchedule(params);
  }
}
