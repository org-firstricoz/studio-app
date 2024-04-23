import 'package:bloc/bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/commons/views/help-center/domain/usecase/help_centre.dart';
import 'package:flutter_riverpod_base/src/commons/views/help-center/presentation/pages/faq_tab.dart';
import 'package:meta/meta.dart';

part 'help_event.dart';
part 'help_state.dart';

class HelpBloc extends Bloc<HelpEvent, HelpState> {
  final HelpCentre _helpCentre;

  HelpBloc({
    required HelpCentre helpCentre,
  })  : _helpCentre = helpCentre,
        super(HelpInitial()) {
    on<HelpEvent>((event, emit) {
      emit(LoadingState());
    });
    on<GetHelpDataEvent>((event, emit) async {
      final res = await _helpCentre.call(event.noParams);
      res.fold((l) => emit(HelpFailureState(message: l.message)),
          (r) => emit(HelpSuccessState(helpData: r)));
    });
  }
}
