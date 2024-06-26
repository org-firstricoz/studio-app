part of 'review_bloc.dart';

@immutable
sealed class ReviewState {}

final class ReviewInitial extends ReviewState {}

class LoadingState extends ReviewState{}
class EditSuccessState extends ReviewState {
  final Map<String, dynamic> results;

  EditSuccessState({required this.results});
}

class AddSuccessState extends ReviewState {
  final Map<String, dynamic> results;

  AddSuccessState({required this.results});
}

class ReviewErrorState extends ReviewState{
  final String message;

  ReviewErrorState(this.message);
}

class DeleteSuccessState extends ReviewState{}
