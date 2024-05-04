part of 'review_bloc.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

class ReviewLoading extends ReviewState {}

class ReviewLoaded extends ReviewState {
  final List<Review> reviews;
  const ReviewLoaded(this.reviews);
}

class ReviewError extends ReviewState {
  final String message;
  const ReviewError(this.message);
}

class ReviewAdded extends ReviewState {}

class ReviewAddedError extends ReviewState {
  final String message;
  const ReviewAddedError(this.message);
}
