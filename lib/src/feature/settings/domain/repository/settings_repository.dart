import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/models/user_model.dart';

abstract class SettingsRepository {
  FutureEither<User> updateData(UpdateParams params);
  FutureEitherVoid deleteAccount();
}
