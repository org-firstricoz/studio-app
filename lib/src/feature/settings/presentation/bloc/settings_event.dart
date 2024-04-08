part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class UpdateEvent extends SettingsEvent {
  final UpdateParams updateParams;

  UpdateEvent({required this.updateParams});
}
