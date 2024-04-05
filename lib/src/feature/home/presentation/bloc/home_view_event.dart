part of 'home_view_bloc.dart';

@immutable
sealed class HomeViewEvent {}

class FetchingStudioDataEvent extends HomeViewEvent {
  final AllParams params;

  FetchingStudioDataEvent({required this.params});
}
