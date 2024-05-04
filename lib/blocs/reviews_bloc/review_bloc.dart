import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_supabase/models/review_model.dart';
import 'package:flutter_supabase/repository/supabase_repository.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final SupabaseRepository repository;

  ReviewBloc(this.repository) : super(ReviewLoading()) {
    on<LoadReviews>((event, emit) async {
      emit(ReviewLoading());
      try {
        final reviews = await repository.fetchReviewsByPlaceId(event.placeId);
        emit(ReviewLoaded(reviews));
      } catch (e) {
        print('Load Reviews Error: $e');  // Add logging
        emit(ReviewError(e.toString()));
      }
    });

    on<AddOrReplaceReview>((event, emit) async {
      try {
        await repository.addOrReplaceReview(event.placeId, event.comment, event.rating);
        add(LoadReviews(event.placeId));  // Reload reviews
        emit(ReviewAdded());
      } catch (e) {
        print('Add/Replace Review Error: $e');  // Add logging
        emit(ReviewAddedError(e.toString()));
      }
    });
  }
}
