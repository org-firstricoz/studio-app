part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  final LogInParams params;

  LoginEvent({required this.params});
}

class SignUpEvent extends AuthEvent {
  final SignUpParams params;

  SignUpEvent({required this.params});
}

class FetchUserLocation extends AuthEvent {
  final NoParams params;

  FetchUserLocation({required this.params});
}

class ManualLocationEvent extends AuthEvent {
  final NoParams params;

  ManualLocationEvent({required this.params});
}

class LoginWithOtpEvent extends AuthEvent {
  final String emailOrPhone;

  LoginWithOtpEvent({required this.emailOrPhone});
}

class SendOtpEvent extends AuthEvent {
  final String emailOrPhone;

  SendOtpEvent({required this.emailOrPhone});
}
