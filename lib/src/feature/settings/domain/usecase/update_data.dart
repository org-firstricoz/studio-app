import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/models/user_model.dart';
import 'package:flutter_riverpod_base/src/core/type_def.dart';
import 'package:flutter_riverpod_base/src/feature/settings/domain/repository/update_data_repository.dart';

class UpdateData implements UseCase<User, UpdateParams> {
  final UpdateDataRepository _updateDataRepository;

  UpdateData({required UpdateDataRepository updateDataRepository})
      : _updateDataRepository = updateDataRepository;

  @override
  FutureEither<User> call(UpdateParams params) {
    // TODO: implement call
    return _updateDataRepository.updateData(params);
  }
}
