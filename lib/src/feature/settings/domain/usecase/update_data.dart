import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/models/user_model.dart';
import 'package:flutter_riverpod_base/src/core/type_def.dart';
import 'package:flutter_riverpod_base/src/feature/settings/domain/repository/settings_repository.dart';

class UpdateData implements UseCase<User, UpdateParams> {
  final SettingsRepository _settingsRepository;

  UpdateData({required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository;

  @override
  FutureEither<User> call(UpdateParams params) {
    // TODO: implement call
    return _settingsRepository.updateData(params);
  }
}
