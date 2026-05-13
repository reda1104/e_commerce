import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/models/location_item_model.dart';

part 'choose_location_state.dart';

class ChooseLocationCubit extends Cubit<ChooseLocationState> {
  ChooseLocationCubit() : super(ChooseLocationInitial());

  String selectedLocationId = dummyLocations.first.id;

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

  void selectLocation(String id) {
    selectedLocationId = id;
    final chosenLocation = dummyLocations.firstWhere(
      (element) => element.id == id,
    );
    emit(LocationChosen(chosenLocation));
  }

  Future<void> confirmLocation() async {
    emit(ConfirmLocationLoading());

    await Future.delayed(const Duration(seconds: 1));

    if (isClosed) return;

    final index = dummyLocations.indexWhere(
      (element) => element.id == selectedLocationId,
    );

    final previousIndex = dummyLocations.indexWhere(
      (element) => element.isChosen == true,
    );

    if (index == -1) return;

    if (previousIndex != -1) {
      dummyLocations[previousIndex] = dummyLocations[previousIndex].copyWith(
        isChosen: false,
      );
    }

    dummyLocations[index] = dummyLocations[index].copyWith(isChosen: true);

    emit(ConfirmLocationLoaded());
  }
}
