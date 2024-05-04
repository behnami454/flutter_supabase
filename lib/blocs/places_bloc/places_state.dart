part of 'places_bloc.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();

  @override
  List<Object> get props => [];
}

class PlaceInitial extends PlaceState {}

class PlaceLoading extends PlaceState {}

class PlaceLoaded extends PlaceState {
  final List<Place> places;
  const PlaceLoaded(this.places);
}

class PlaceError extends PlaceState {
  final String message;
  PlaceError(this.message);
}
