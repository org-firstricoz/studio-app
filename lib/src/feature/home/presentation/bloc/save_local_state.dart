part of 'save_local_bloc.dart';

@immutable
sealed class SaveLocalState {}

final class SaveLocalInitial extends SaveLocalState {}

final class SaveState extends SaveLocalState{}

final class SaveLocalFailure extends SaveLocalState{}