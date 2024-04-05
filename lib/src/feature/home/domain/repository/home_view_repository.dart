import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';

abstract class HomeViewRepository {
  FutureEither<Map<String, List<StudioModel>>> getHomeViewDetails(
      AllParams params);

}
