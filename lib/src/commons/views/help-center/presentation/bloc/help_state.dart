part of 'help_bloc.dart';

@immutable
sealed class HelpState {}

final class HelpInitial extends HelpState {}

class LoadingState extends HelpState {}

class HelpFailureState extends HelpState {
  final String message;

  HelpFailureState({required this.message});
}

class HelpSuccessState extends HelpState {
  final List<CustomExpadedTile> helpData;

  HelpSuccessState({required this.helpData});
}


