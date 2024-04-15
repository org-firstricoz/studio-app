import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/type_def.dart';
import 'package:flutter_riverpod_base/src/feature/settings/domain/repository/settings_repository.dart';

class DeleteAccount implements UseCase<void, NoParams> {
  final SettingsRepository _settingsRepository;

  DeleteAccount({required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository;
  @override
  FutureEitherVoid call(NoParams params) {
    // TODO: implement call
    return _settingsRepository.deleteAccount();
  }
}
