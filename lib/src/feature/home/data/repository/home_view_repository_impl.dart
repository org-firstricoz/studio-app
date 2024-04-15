import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/core/type_def.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';
import 'package:flutter_riverpod_base/src/feature/home/data/datasource/remote_data_source.dart';
import 'package:flutter_riverpod_base/src/feature/home/domain/repository/home_view_repository.dart';

class HomeViewRepositoryImpl implements HomeViewRepository {
  final HomeViewRemoteDataSource _dataSource;

  HomeViewRepositoryImpl({required HomeViewRemoteDataSource dataSource})
      : _dataSource = dataSource;
  @override
  FutureEither<Map<String, List<StudioModel>>> getHomeViewDetails(
      AllParams params) {
    return _dataSource.getHomeViewDetails(params);
  }

  FutureEitherVoid saveFavourites(List<StudioModel> params) {
    return _dataSource.saveFavourites(params);
  }
}
