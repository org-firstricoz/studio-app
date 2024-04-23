// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'help_bloc.dart';

@immutable
sealed class HelpEvent {}

class GetHelpDataEvent extends HelpEvent {
  final String noParams;
  GetHelpDataEvent({
    required this.noParams,
  });
}

