// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod_base/src/feature/auth/domain/repository/auth_repository.dart';

import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/models/location_model.dart';
import 'package:flutter_riverpod_base/src/core/models/user_model.dart';

// Creating User
class CreateUserWithEmailAndPassword implements UseCase<User, SignUpParams> {
  final AuthRepository _authRepository;

  CreateUserWithEmailAndPassword({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  FutureEither<User> call(SignUpParams params) async {
    // TODO: implement call
    return await _authRepository.createUserWithEmailAndPassword(params);
  }
}

// Logging User
class LoginUserWithEmailAndPassword implements UseCase<User, LogInParams> {
  final AuthRepository _authRepository;

  LoginUserWithEmailAndPassword({required AuthRepository authRepository})
      : _authRepository = authRepository;
  @override
  FutureEither<User> call(LogInParams params) async {
    // TODO: implement call
    return await _authRepository.loginUserWithEmailAndPassword(params);
  }
}

// Start from Here
// 23-03-2024
class GetLocation implements UseCase<String, NoParams> {
  final AuthRepository _authRepository;

  GetLocation({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  FutureEither<String> call(NoParams params) async {
    print('object');
    return await _authRepository.getUserLocation(params);
  }
}

class ManualLocation implements UseCase<List<LocationModel>, NoParams> {
  final AuthRepository _authRepository;

  ManualLocation({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  FutureEither<List<LocationModel>> call(NoParams params) async {
    return await _authRepository.manualLocation(params);
  }
}

class LoginWithOtp implements UseCase<User, String> {
  final AuthRepository _authRepository;

  LoginWithOtp({required AuthRepository authRepository})
      : _authRepository = authRepository;
  @override
  FutureEither<User> call(String params) async {
    // TODO: implement call
    return await _authRepository.loginUsingOtp(params);
  }
}

class SendOtp implements UseCase<String, String> {
  final AuthRepository _authRepository;

  SendOtp({required AuthRepository authRepository})
      : _authRepository = authRepository;
  @override
  FutureEither<String> call(params) async {
    return await _authRepository.sendOtp(params);
  }
}
