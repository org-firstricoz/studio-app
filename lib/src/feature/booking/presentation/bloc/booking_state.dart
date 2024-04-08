part of 'booking_bloc.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

final class LoadingState extends BookingState {}

class BookingFailure extends BookingState {
  final String message;

  BookingFailure(this.message);
}

class BookingSuccessState extends BookingState {
  final Map<String, dynamic> results;

  BookingSuccessState({required this.results});
}

class ReviewSuccessState extends BookingState {
  final ReviewModel reviewModel;

  ReviewSuccessState({required this.reviewModel});
}

class OrderSuccessState extends BookingState {
  final Map<String, dynamic> options;
  OrderSuccessState({required this.options});
}

class PaymentSuccessState extends BookingState {
  final Map<String, dynamic> data;

  PaymentSuccessState({required this.data});
}
