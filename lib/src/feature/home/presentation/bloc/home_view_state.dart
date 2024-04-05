part of 'home_view_bloc.dart';

@immutable
sealed class AllDataState<T> {}

final class HomeViewInitial extends AllDataState {}

class LoadingState extends AllDataState {}

class HomeViewFailure extends AllDataState {
  final String message;

  HomeViewFailure({required this.message});
}

class HomeViewSuccess extends AllDataState {
  final Map<String, List<StudioModel>> modelDatas;

  HomeViewSuccess({required this.modelDatas});
}

class StudioDetailsSuccessState extends AllDataState {
  final StudioDetails studioDetails;

  StudioDetailsSuccessState({required this.studioDetails});
}
