import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/models/user_model.dart';
import 'package:flutter_riverpod_base/src/core/type_def.dart';
import 'package:flutter_riverpod_base/src/feature/settings/data/datasource/update_data_data_source.dart';
import 'package:flutter_riverpod_base/src/feature/settings/domain/repository/update_data_repository.dart';

class UpdateDataRepositoryImpl implements UpdateDataRepository {
  final UpdateDataDataSource _dataSource;

  UpdateDataRepositoryImpl({required UpdateDataDataSource dataSource})
      : _dataSource = dataSource;
  @override
  FutureEither<User> updateData(UpdateParams params) {
    return _dataSource.updateData(params);
  }
}
