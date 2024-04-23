import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/commons/views/help-center/presentation/pages/faq_tab.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';

abstract class HelpCentreRepository {
  FutureEither<List<CustomExpadedTile>> getHelpData(String noparams);
  

}
