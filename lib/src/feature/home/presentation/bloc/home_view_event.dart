part of 'home_view_bloc.dart';

@immutable
sealed class HomeViewEvent {}

class FetchingStudioDataEvent extends HomeViewEvent {
  final AllParams params;

  FetchingStudioDataEvent({required this.params});
}

class SavingFavouritesEvent extends HomeViewEvent {
  final List<StudioModel> params;

  SavingFavouritesEvent({required this.params});
}
