part of 'booking_bloc.dart';

@immutable
sealed class BookingEvent {}

class GetBookingDataEvent extends BookingEvent {
  final StudioParams params;

  GetBookingDataEvent({required this.params});
}

class AddReviewEvent extends BookingEvent {
  final ReviewParams params;

  AddReviewEvent({required this.params});
}

class RequestScheduleEvent extends BookingEvent {
  final RequestParams requestParams;

  RequestScheduleEvent({required this.requestParams});
}
