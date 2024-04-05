import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/models/location_model.dart';
import 'package:flutter_riverpod_base/src/core/models/user_model.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/repository/auth_repository.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ManualLocation _manualLocation;
  final CreateUserWithEmailAndPassword _createUserWithEmailAndPassword;
  final LoginUserWithEmailAndPassword _loginUserWithEmailAndPassword;
  final GetLocation _getLocation;
  final LoginWithOtp _loginWithOtp;
  final SendOtp _sendOtp;

  AuthBloc(
      {required ManualLocation manualLocation,
      required LoginWithOtp loginWithOtp,
      required SendOtp sendOtp,
      required CreateUserWithEmailAndPassword createUserWithEmailAndPassword,
      required LoginUserWithEmailAndPassword loginUserWithEmailAndPassword,
      required GetLocation getLocation})
      : _manualLocation = manualLocation,
        _sendOtp = sendOtp,
        _loginWithOtp = loginWithOtp,
        _createUserWithEmailAndPassword = createUserWithEmailAndPassword,
        _loginUserWithEmailAndPassword = loginUserWithEmailAndPassword,
        _getLocation = getLocation,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(LoadingState());
    });

    // LoggingIn user
    on<LoginEvent>(
      (event, emit) async {
        final res = await _loginUserWithEmailAndPassword.call(event.params);

        res.fold((l) => emit(AuthFailure(message: l.message)),
            (r) => emit(AuthSuccess(user: r)));
      },
    );
    // SigningUp User
    on<SignUpEvent>(
      (event, emit) async {
        final res = await _createUserWithEmailAndPassword.call(event.params);

        res.fold((l) => emit(AuthFailure(message: l.message)), (r) {
          return emit(AuthSuccess(user: r));
        });
      },
    );
// Fetching User Location Automatically
    on<FetchUserLocation>(
      (event, emit) async {
        final res = await _getLocation.call(event.params);

        res.fold((l) => emit(LocationFailure(message: l.message)),
            (r) => emit(LocationSuccess(city: r)));
      },
    );
// Fetching User Location Manually
    on<ManualLocationEvent>((event, emit) async {
      final res = await _manualLocation.call(event.params);

      res.fold((l) => emit(ManualLocationFailureState(message: l.message)),
          (r) => emit(ManualLocationSuccessState(models: r)));
    });

    // Login using OTP
    on<LoginWithOtpEvent>(
      (event, emit) async {
        final res = await _loginWithOtp.call(event.emailOrPhone);
        res.fold((l) => emit(AuthFailure(message: l.message)),
            (r) => emit(AuthSuccess(user: r)));
      },
    );

    on<SendOtpEvent>(
      (event, emit) async {
        final res = await _sendOtp.call(event.emailOrPhone);
        res.fold((l) => emit(AuthFailure(message: l.message)),
            (r) => emit(OtpSuccessState(otp: r)));
      },
    );
  }
}
