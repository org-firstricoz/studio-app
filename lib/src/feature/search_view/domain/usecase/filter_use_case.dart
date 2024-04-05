import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/domain/repository/filter_repository.dart';

class FilterUseCase implements UseCase<List<StudioModel>, FilterParams> {
  final FilterRepository _filterRepository;

  FilterUseCase({required FilterRepository filterRepository})
      : _filterRepository = filterRepository;
  @override
  FutureEither<List<StudioModel>> call(FilterParams params) async {
    return await _filterRepository.getFilteredResults(params);
  }
}
