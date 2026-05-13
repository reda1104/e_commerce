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

final class LocationChosen extends ChooseLocationState {
  final LocationItemModel location;

  LocationChosen(this.location);
}

final class ConfirmLocationLoading extends ChooseLocationState {}

final class ConfirmLocationLoaded extends ChooseLocationState {}

final class ConfirmLocationFailure extends ChooseLocationState {
  final String message;

  ConfirmLocationFailure(this.message);
}
