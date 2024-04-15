import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/models/user_model.dart';
import 'package:flutter_riverpod_base/src/core/type_def.dart';
import 'package:flutter_riverpod_base/src/feature/settings/data/datasource/settings_data_source.dart';
import 'package:flutter_riverpod_base/src/feature/settings/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDataSource _dataSource;

  SettingsRepositoryImpl({required SettingsDataSource dataSource})
      : _dataSource = dataSource;
  @override
  FutureEither<User> updateData(UpdateParams params) {
    return _dataSource.updateData(params);
  }

  FutureEitherVoid deleteAccount() {
    return _dataSource.deleteAccount();
  }
}
