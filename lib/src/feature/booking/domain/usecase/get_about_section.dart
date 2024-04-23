import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/type_def.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';
import 'package:flutter_riverpod_base/src/feature/booking/domain/repository/booking_repository.dart';

class GetAboutSection implements UseCase<Map<String, dynamic>, StudioParams> {
  final BookingRepository _bookingRepository;

  GetAboutSection({required BookingRepository bookingRepository})
      : _bookingRepository = bookingRepository;
  @override
  FutureEither<Map<String, dynamic>> call(StudioParams params) async {
    return await _bookingRepository.getAboutSection(params.uid);
  }
}

class AddReviewSection implements UseCase<Map<String, dynamic>, ReviewParams> {
  final BookingRepository _bookingRepository;

  AddReviewSection({required BookingRepository bookingRepository})
      : _bookingRepository = bookingRepository;

  @override
  FutureEither<Map<String, dynamic>> call(ReviewParams params) {
    return _bookingRepository.addReviewSection(params);
  }
}

class DeleteReviewSction implements UseCase<Map<String, dynamic>, String> {
  final BookingRepository _bookingRepository;

  DeleteReviewSction({required BookingRepository bookingRepository})
      : _bookingRepository = bookingRepository;
  @override
 FutureEither<Map<String, dynamic>>  call(String params) {
    return _bookingRepository.delteReview(params);
  }
}

class EditReviewSction implements UseCase<Map<String, dynamic>, ReviewParams> {
  final BookingRepository _bookingRepository;

  EditReviewSction({required BookingRepository bookingRepository})
      : _bookingRepository = bookingRepository;
  @override
  FutureEither<Map<String, dynamic>> call(ReviewParams params) {
    // TODO: implement call
    return _bookingRepository.editReview(params);
  }
}
