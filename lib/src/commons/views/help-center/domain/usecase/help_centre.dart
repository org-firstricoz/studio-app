import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/commons/views/help-center/domain/repository/help_centre_repository.dart';
import 'package:flutter_riverpod_base/src/commons/views/help-center/presentation/pages/faq_tab.dart';
import 'package:flutter_riverpod_base/src/core/type_def.dart';

class HelpCentre implements UseCase<List<CustomExpadedTile>, String> {
  final HelpCentreRepository _helpCentreRepository;

  HelpCentre({required HelpCentreRepository helpCentreRepository}) : _helpCentreRepository = helpCentreRepository;
  @override
  FutureEither<List<CustomExpadedTile>> call(String params)async {
    
  return  _helpCentreRepository.getHelpData(params);
  }
}

