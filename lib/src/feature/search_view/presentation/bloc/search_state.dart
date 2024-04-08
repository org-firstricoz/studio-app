part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

class LoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final List<StudioModel> models;

  SearchSuccessState({required this.models});
}

class SearchFailureState extends SearchState {
  final String message;

  SearchFailureState({required this.message});
}

class FilterSuccessState extends SearchState {
  final List<StudioModel> models;

  FilterSuccessState({required this.models});
}
