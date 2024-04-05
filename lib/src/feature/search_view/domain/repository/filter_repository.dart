import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';

abstract class FilterRepository {

  FutureEither<List<StudioModel>> getFilteredResults(FilterParams params);
}
