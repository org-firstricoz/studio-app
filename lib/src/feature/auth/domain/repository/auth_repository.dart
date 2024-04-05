import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/models/location_model.dart';
import 'package:flutter_riverpod_base/src/core/models/user_model.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';
import 'package:http/http.dart';

abstract class AuthRepository {
  FutureEither<User> createUserWithEmailAndPassword(SignUpParams params);

  FutureEither<User> loginUserWithEmailAndPassword(LogInParams params);

  FutureEither<String> getUserLocation(NoParams params);

  FutureEither<List<LocationModel>> manualLocation(NoParams params);

  FutureEither<User> loginUsingOtp(String params);

  FutureEither<String> sendOtp(String params);
}
