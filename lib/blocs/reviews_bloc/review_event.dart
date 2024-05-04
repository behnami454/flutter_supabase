part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();
}

class LoadReviews extends ReviewEvent {
  final int placeId;

  const LoadReviews(this.placeId);

  @override
  List<Object> get props => [placeId];
}

class AddOrReplaceReview extends ReviewEvent {
  final int placeId;
  final String comment;
  final int rating;
  const AddOrReplaceReview(this.placeId, this.comment, this.rating);

  @override
  List<Object?> get props => [placeId, comment, rating];
}
