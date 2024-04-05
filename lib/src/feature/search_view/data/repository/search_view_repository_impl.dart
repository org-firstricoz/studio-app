import 'package:flutter_riverpod_base/src/core/type_def.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/data/datasource/remote_data_source.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/domain/repository/search_view_repository.dart';

class SearchViewRepositoryImpl implements SearchViewRepository {
  final SearchViewRemoteDataSource _remoteDataSource;

  SearchViewRepositoryImpl(this._remoteDataSource);
  @override
  FutureEither<Map<String, dynamic>> getSearchResults(String searchTerm) async{
    return await _remoteDataSource.getSearchResults(searchTerm);
  }
}
