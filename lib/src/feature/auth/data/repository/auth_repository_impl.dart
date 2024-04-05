import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/models/location_model.dart';
import 'package:flutter_riverpod_base/src/core/models/user_model.dart';
import 'package:flutter_riverpod_base/src/core/type_def.dart';
import 'package:flutter_riverpod_base/src/feature/auth/data/datasource/remote_data_source.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl({required AuthRemoteDataSource authRemoteDataSource})
      : _authRemoteDataSource = authRemoteDataSource;

  @override
  FutureEither<User> createUserWithEmailAndPassword(SignUpParams params) async {
    return await _authRemoteDataSource.createUserWithEmailAndPassword(params);
  }

  @override
  FutureEither<String> getUserLocation(NoParams params) async {
    return await _authRemoteDataSource.getUserLocation(params);
  }

  @override
  FutureEither<User> loginUserWithEmailAndPassword(LogInParams params) async {
    return await _authRemoteDataSource.loginUserWithEmailAndPassword(params);
  }

  @override
  FutureEither<List<LocationModel>> manualLocation(NoParams params) async {
    return await _authRemoteDataSource.manualLocation(params);
  }

  @override
  FutureEither<User> loginUsingOtp(String params) async {
    return await _authRemoteDataSource.loginUsingOtp(params);
  }

  @override
FutureEither<String> sendOtp(String params)async{
  return await _authRemoteDataSource.sendOtp(params);
}
  
}
