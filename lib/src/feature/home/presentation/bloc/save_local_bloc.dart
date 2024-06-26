// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/feature/home/domain/usecase/get_home_view_details.dart';

part 'save_local_event.dart';
part 'save_local_state.dart';

class SaveLocalBloc extends Bloc<SaveLocalEvent, SaveLocalState> {
  final SaveFavouritesLocally _saveFavouritesLocally;
  SaveLocalBloc({required SaveFavouritesLocally saveFavouritesLocally})
      : _saveFavouritesLocally = saveFavouritesLocally,
        super(SaveLocalInitial()) {
    on<SaveLocalEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SaveLocally>((event, emit) async {
      // TODO: implement event handler
      final res = await _saveFavouritesLocally.call(event.params);
      res.fold(
          (l) => emit(SaveLocalFailure()), (r) => emit(SaveLocalInitial()));
    });
  }
}
