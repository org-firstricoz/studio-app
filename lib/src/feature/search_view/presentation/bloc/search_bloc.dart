import 'package:bloc/bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/domain/usecase/filter_use_case.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/domain/usecase/search_view.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchView _searchView;
  final FilterUseCase _filterUseCase;
  SearchBloc(
      {required SearchView searchView, required FilterUseCase filterUseCase})
      : _searchView = searchView,
        _filterUseCase = filterUseCase,
        super(SearchInitial()) {
    on<SearchEvent>((event, emit) {
      emit(LoadingState());
    });

    on<GetSearchResultsEvent>(
      (event, emit) async {
        final res = await _searchView.call(event.query);
        res.fold((l) => emit(SearchFailureState(message: l.message)),
            (r) => emit(SearchSuccessState(models: r['search_result'])));
      },
    );
    on<GetFilterResultsEvent>(
      (event, emit) async {
        final res = await _filterUseCase.call(event.filterParams);
        res.fold((l) => emit(SearchFailureState(message: l.message)),
            (r) => emit(FilterSuccessState(models: r)));
      },
    );
  }
}
