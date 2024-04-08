import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_details.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';
import 'package:flutter_riverpod_base/src/feature/booking/domain/usecase/get_about_section.dart';
import 'package:flutter_riverpod_base/src/feature/booking/domain/usecase/requesting_schedule.dart';
import 'package:meta/meta.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final GetAboutSection _getAboutSection;
  final AddReviewSection _addReviewSection;
  final RequestingSchedule _requestingSchedule;
  final SendingData _sendingData;
  BookingBloc(
      {required RequestingSchedule requestingSchedule,
      required GetAboutSection getAboutSection,
      required AddReviewSection addreviewSection,
      required SendingData sendingData})
      : _getAboutSection = getAboutSection,
        _sendingData = sendingData,
        _addReviewSection = addreviewSection,
        _requestingSchedule = requestingSchedule,
        super(BookingInitial()) {
    on<BookingEvent>((event, emit) {
      emit(LoadingState());
    });

    on<GetBookingDataEvent>(
      (event, emit) async {
        final res = await _getAboutSection.call(event.params);

        res.fold((l) => emit(BookingFailure(l.message)),
            (r) => emit(BookingSuccessState(results: r)));
      },
    );

    on<AddReviewEvent>(
      (event, emit) async {
        final res = await _addReviewSection.call(event.params);
        res.fold((l) => emit(BookingFailure(l.message)),
            (r) => emit(BookingSuccessState(results: r)));
      },
    );
    on<RequestScheduleEvent>(
      (event, emit) async {
        final res = await _requestingSchedule.call(event.requestParams);
        res.fold((l) => emit(BookingFailure(l.message)),
            (r) => emit(OrderSuccessState(options: r)));
      },
    );
    on<PaymentEvent>(
      (event, emit) async {
        final res = await sendingData.call(event.data);
        res.fold((l) => emit(BookingFailure(l.message)),
            (r) => emit(PaymentSuccessState(data: r)));
      },
    );
  }
}
