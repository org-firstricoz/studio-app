part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

class UpdateSuccessState extends SettingsState {
  final User user;

  UpdateSuccessState({required this.user});
}

class SettingsFailureState extends SettingsState {
  final String message;

  SettingsFailureState({required this.message});
}

class LoadingState extends SettingsState {}

class SettingsDeleteSuccess extends SettingsState {}
