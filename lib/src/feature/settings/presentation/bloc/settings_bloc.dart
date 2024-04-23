import 'package:bloc/bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/models/user_model.dart';
import 'package:flutter_riverpod_base/src/feature/settings/domain/usecase/delete_account.dart';
import 'package:flutter_riverpod_base/src/feature/settings/domain/usecase/update_data.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final DeleteAccount _deleteAccount;
  final UpdateData _updateData;
  SettingsBloc(
      {required UpdateData updateData, required DeleteAccount deleteAccount})
      : _updateData = updateData,
        _deleteAccount = deleteAccount,
        super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) {
      emit(LoadingState());
    });
    on<UpdateEvent>(
      (event, emit) async {
        final res = await _updateData.call(event.updateParams);
        res.fold((l) => emit(SettingsFailureState(message: l.message)),
            (r) => emit(UpdateSuccessState(user: r)));
      },
    );
    on<DeleteAccountEvent>(
      (event, emit) async {
        final res = await _deleteAccount.call(event.noParams);
        res.fold((l) => emit(SettingsFailureState(message: l.message)),
            (r) => emit(SettingsDeleteSuccess()));
      },
    );
  }
}
