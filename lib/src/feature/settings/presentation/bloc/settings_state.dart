part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

class UpdateSuccessState extends SettingsState {
  final User user;

  UpdateSuccessState({required this.user});
}

class UpdateFailureState extends SettingsState {
  final String message;

  UpdateFailureState({required this.message});
}

class LoadingState extends SettingsState{}