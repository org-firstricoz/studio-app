import 'package:bloc/bloc.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_model.dart';
import 'package:flutter_riverpod_base/src/feature/search_view/domain/usecase/search_view.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchView _searchView;
  SearchBloc({required SearchView searchView})
      : _searchView = searchView,
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
  }
}
