part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class UpdateEvent extends SettingsEvent {
  final UpdateParams updateParams;

  UpdateEvent({required this.updateParams});
}

class DeleteAccountEvent extends SettingsEvent {
  final NoParams noParams;

  DeleteAccountEvent({required this.noParams});
}
