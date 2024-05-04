import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_supabase/models/places_model.dart';
import 'package:flutter_supabase/repository/supabase_repository.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final SupabaseRepository repository;

  PlaceBloc(this.repository) : super(PlaceInitial()) {
    on<LoadPlaces>((event, emit) async {
      emit(PlaceLoading());
      try {
        final places = await repository.fetchPlaces();
        emit(PlaceLoaded(places));
      } catch (e) {
        emit(PlaceError(e.toString()));
      }
    });
  }
}
