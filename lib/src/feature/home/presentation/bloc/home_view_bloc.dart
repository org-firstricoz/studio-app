import 'package:bloc/bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/core.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_details.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/booking_view.dart';
import 'package:flutter_riverpod_base/src/feature/home/domain/usecase/get_home_view_details.dart';
import 'package:flutter_riverpod_base/src/utils/functions.dart';
import 'package:meta/meta.dart';

part 'home_view_event.dart';
part 'home_view_state.dart';

class HomeViewBloc extends Bloc<HomeViewEvent, AllDataState> {
  final GetHomeViewDetails _getHomeViewDetails;
  HomeViewBloc(
    GetHomeViewDetails getHomeViewDetails,
  )   : _getHomeViewDetails = getHomeViewDetails,
        super(HomeViewInitial()) {
    on<HomeViewEvent>((event, emit) {
      emit(LoadingState());
    });

    on<FetchingStudioDataEvent>(
      (event, emit) async {
        try {
          await locationFromAdd(user.location);
          final res = await _getHomeViewDetails.call(event.params);
          res.fold((l) => emit(HomeViewFailure(message: l.message)),
              (r) => emit(HomeViewSuccess(modelDatas: r)));
        } catch (e) {
          return emit(HomeViewFailure(message: 'unable to load'));
        }
      },
    );
  }
}