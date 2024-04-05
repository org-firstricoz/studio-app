part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class LoadingState extends AuthState {}

class CreatingUserState extends AuthState {
  final Response response;

  CreatingUserState({required this.response});
}

class LogginUserState extends AuthState {
  final Response response;

  LogginUserState({required this.response});
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});
}

class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess({required this.user});
}

class LocationFailure extends AuthState {
  final String message;

  LocationFailure({required this.message});
}

class LocationSuccess extends AuthState {
  final String city;
  LocationSuccess({required this.city});
}

class ManualLocationFetchingState extends AuthState {
  final Response response;

  ManualLocationFetchingState({required this.response});
}

class ManualLocationFailureState extends AuthState {
  final String message;

  ManualLocationFailureState({required this.message});
}

class ManualLocationSuccessState extends AuthState {
  final List<LocationModel> models;

  ManualLocationSuccessState({required this.models});
}

class OtpSuccessState extends AuthState {
  final String otp;

  OtpSuccessState({required this.otp});
}
