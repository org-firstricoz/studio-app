import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_details.dart';
import 'package:flutter_riverpod_base/src/core/type_def.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';
import 'package:flutter_riverpod_base/src/feature/booking/data/datasource/remote_data_source.dart';
import 'package:flutter_riverpod_base/src/feature/booking/domain/repository/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final RemoteDataSource remoteDataSource;

  BookingRepositoryImpl({required this.remoteDataSource});

  @override
  FutureEither<Map<String, dynamic>> getAboutSection(String uid) async {
    return await remoteDataSource.getAboutSection(uid);
  }

  @override
  FutureEither<Map<String, dynamic>> addReviewSection(
      ReviewParams params) async {
    return await remoteDataSource.addReviewSection(params);
  }
}
