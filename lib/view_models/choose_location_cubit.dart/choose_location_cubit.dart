import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/models/location_item_model.dart';

part 'choose_location_state.dart';

class ChooseLocationCubit extends Cubit<ChooseLocationState> {
  ChooseLocationCubit() : super(ChooseLocationInitial());

  void fetchLocations() {
    emit(FetchingLocations());
    Future.delayed(const Duration(seconds: 1), () {
      emit(FetchedLocations(dummyLocations));
    });
  }

  void addLocation(String location) {
    emit(AddingLocation());
    Future.delayed(const Duration(seconds: 1), () {
      final city = location.split(",")[0];
      final country = location.split(",")[1];
      final locationItem = LocationItemModel(
        id: DateTime.now().toIso8601String(),
        city: city,
        country: country,
      );
      dummyLocations.add(locationItem);
      emit(LocationAdded());
      emit(FetchedLocations(dummyLocations));
    });
  }
}
