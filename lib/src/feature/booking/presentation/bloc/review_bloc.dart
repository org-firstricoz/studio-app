import 'package:bloc/bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/feature/booking/domain/usecase/get_about_section.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/bloc/booking_bloc.dart';
import 'package:meta/meta.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final EditReviewSction _editReviewSction;
  final DeleteReviewSction _deleteReviewSction;
  final AddReviewSection _addReviewSection;

  ReviewBloc(
      {required EditReviewSction editReviewSction,
      required DeleteReviewSction deleteReviewSction,
      required AddReviewSection addReviewSection})
      : _addReviewSection = addReviewSection,
        _deleteReviewSction = deleteReviewSction,
        _editReviewSction = editReviewSction,
        super(ReviewInitial()) {
    on<ReviewEvent>((event, emit) {
      emit(LoadingState());
    });

    on<AddReviewEvent>(
      (event, emit) async {
        final res = await _addReviewSection.call(event.params);
        res.fold((l) => emit(ReviewErrorState(l.message)),
            (r) => emit(AddSuccessState(results: r)));
      },
    );

    on<EditReviewEvent>(
      (event, emit) async {
        final res = await _editReviewSction.call(event.reviewParams);
        res.fold((l) => emit(ReviewErrorState(l.message)),
            (r) => emit(EditSuccessState(results: r)));
      },
    );

    on<DeleteReviewEvent>(
      (event, emit) async {
        final res = await _deleteReviewSction.call(event.reviewId);
        res.fold((l) => emit(ReviewErrorState(l.message)),
            (r) => emit(DeleteSuccessState()));
      },
    );
  }
}
