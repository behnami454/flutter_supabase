import 'package:flutter_supabase/models/places_model.dart';
import 'package:flutter_supabase/models/review_model.dart';

import 'package:flutter_supabase/api/supabase_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRepository {
  final SupabaseManager supabaseManager = SupabaseManager();

  SupabaseRepository(SupabaseManager supabaseManager);

  Future<List<Place>> fetchPlaces() async {
    final response = await supabaseManager.client.from('places').select();

    if (response.isEmpty) {
      throw Exception('No places found');
    }

    List<Place> places = response.map((placeJson) => Place.fromJson(placeJson)).toList();

    return places;
  }

  Future<List<Review>> fetchReviewsByPlaceId(int placeId) async {
    final response = await supabaseManager.client.from('reviews').select().eq('place_id', placeId);

    if (response.isEmpty) {
      throw Exception('No places found');
    }

    List<Review> reviews = response.map((reviewJson) => Review.fromJson(reviewJson)).toList();

    return reviews;
  }

  Future<AuthResponse> signInWithEmail(String email, String password) async {
    AuthResponse login = await supabaseManager.client.auth.signInWithPassword(email: email, password: password);

    return login;
  }

  Future<void> addOrReplaceReview(int placeId, String comment, int rating) async {
    var response = await supabaseManager.client
        .from('reviews')
        .upsert({'place_id': placeId, 'comment': comment, 'rating': rating});

    if (response.error != null) {
      throw Exception('Failed to add or replace review: ${response.error.message}');
    }
  }
}
