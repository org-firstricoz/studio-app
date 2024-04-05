part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class GetSearchResultsEvent extends SearchEvent {
  final String query;
  GetSearchResultsEvent({required this.query});
}
