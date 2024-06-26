part of 'review_bloc.dart';

@immutable
sealed class ReviewEvent {}

class DeleteReviewEvent extends ReviewEvent {
  final String reviewId;

  DeleteReviewEvent({required this.reviewId});
}

class EditReviewEvent extends ReviewEvent {
  final ReviewParams reviewParams;

  EditReviewEvent({required this.reviewParams});
}

class AddReviewEvent extends ReviewEvent {
  final ReviewParams params;

  AddReviewEvent({required this.params});
}