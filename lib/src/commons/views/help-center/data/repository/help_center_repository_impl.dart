import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/commons/views/help-center/data/datasource/remote_data_source.dart';
import 'package:flutter_riverpod_base/src/commons/views/help-center/domain/repository/help_centre_repository.dart';
import 'package:flutter_riverpod_base/src/commons/views/help-center/presentation/pages/faq_tab.dart';
import 'package:flutter_riverpod_base/src/core/type_def.dart';

class HelpCentreRepositoryImpl implements HelpCentreRepository {
  final HelpCenterRemoteDataSource _helpCenterRemoteDataSource;

  HelpCentreRepositoryImpl(
      {required HelpCenterRemoteDataSource helpCenterRemoteDataSource})
      : _helpCenterRemoteDataSource = helpCenterRemoteDataSource;
  @override
  FutureEither<List<CustomExpadedTile>> getHelpData(String noparams) {

    return _helpCenterRemoteDataSource.getHelpData(noparams);
  }


}
