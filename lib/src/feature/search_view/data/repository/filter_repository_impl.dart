import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/core/type_def.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/data/datasource/filter_data_source.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/domain/repository/filter_repository.dart';

class FilterRepositoryImpl implements FilterRepository {
  final FilterDataSource _filterDataSource;

  FilterRepositoryImpl({required FilterDataSource filterDataSource})
      : _filterDataSource = filterDataSource;
  @override
  FutureEither<List<StudioModel>> getFilteredResults(
      FilterParams params) async {
    // TODO: implement getFilteredResults
    return await _filterDataSource.getFilteredResults(params);  
  }
}
