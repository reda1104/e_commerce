part of 'choose_location_cubit.dart';

sealed class ChooseLocationState {}

final class ChooseLocationInitial extends ChooseLocationState {}

final class FetchingLocations extends ChooseLocationState {}

final class FetchedLocations extends ChooseLocationState {
  final List<LocationItemModel> locations;

  FetchedLocations(this.locations);
}

final class FetchLocationFailure extends ChooseLocationState {
  final String message;

  FetchLocationFailure(this.message);
}

final class AddingLocation extends ChooseLocationState {}

final class LocationAdded extends ChooseLocationState {}

final class LocationAddingFailure extends ChooseLocationState {
  final String message;

  LocationAddingFailure(this.message);
}
