import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_details.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';

abstract class BookingRepository {
  FutureEither<Map<String, dynamic>> getAboutSection(String uid);
  FutureEither<Map<String, dynamic>> addReviewSection(ReviewParams params);
   FutureEither<Map<String, dynamic>>  delteReview(String reviewId);
  FutureEither<Map<String, dynamic>> editReview(ReviewParams params);
}
