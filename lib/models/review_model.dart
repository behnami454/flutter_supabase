class Review {
  final int id;
  final int placeId;
  final int rating;
  final String comment;

  Review({
    required this.id,
    required this.placeId,
    required this.rating,
    required this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      placeId: json['place_id'],
      rating: json['rating'],
      comment: json['comment'],
    );
  }
}
