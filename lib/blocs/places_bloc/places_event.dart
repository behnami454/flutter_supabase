part of 'places_bloc.dart';

abstract class PlaceEvent extends Equatable {
  const PlaceEvent();
}

class LoadPlaces extends PlaceEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
