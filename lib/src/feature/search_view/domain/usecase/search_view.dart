import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/type_def.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/domain/repository/search_view_repository.dart';

class SearchView implements UseCase<Map<String, dynamic>, String> {
  final SearchViewRepository _searchViewRepository;

  SearchView({required SearchViewRepository searchViewRepository})
      : _searchViewRepository = searchViewRepository;
  @override
  FutureEither<Map<String, dynamic>> call(String params) async {
    return await _searchViewRepository.getSearchResults(params);
  }
}
