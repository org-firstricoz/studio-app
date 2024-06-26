import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/core/type_def.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';
import 'package:flutter_riverpod_base/src/feature/home/domain/repository/home_view_repository.dart';

class GetHomeViewDetails
    implements UseCase<Map<String, List<StudioModel>>, AllParams> {
  final HomeViewRepository _homeViewRepository;

  GetHomeViewDetails({required HomeViewRepository homeViewRepository})
      : _homeViewRepository = homeViewRepository;
  @override
  FutureEither<Map<String, List<StudioModel>>> call(AllParams params) {
    return _homeViewRepository.getHomeViewDetails(params);
  }
}

class SaveFavourites implements UseCase<void, List<StudioModel>> {
  final HomeViewRepository _homeViewRepository;

  SaveFavourites({required HomeViewRepository homeViewRepository})
      : _homeViewRepository = homeViewRepository;
  @override
  FutureEither<void> call(List<StudioModel> params) {
    return _homeViewRepository.saveFavourites(params);
  }
}

class SaveFavouritesLocally implements UseCase<void, List<StudioModel>> {
  final HomeViewRepository _homeViewRepository;

  SaveFavouritesLocally({required HomeViewRepository homeViewRepository})
      : _homeViewRepository = homeViewRepository;
  @override
  FutureEither<void> call(List<StudioModel> params) {
    return _homeViewRepository.saveFavouritesLocally(params);
  }
}
