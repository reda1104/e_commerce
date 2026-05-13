import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_models/choose_location_cubit.dart/choose_location_cubit.dart';
import 'package:e_commerce/views/widgets/location_item.dart';
import 'package:e_commerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseLocationPage extends StatefulWidget {
  const ChooseLocationPage({super.key});

  @override
  State<ChooseLocationPage> createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {
  final TextEditingController _locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ChooseLocationCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Address")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose your location",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                Text(
                  "Let's find an unforgettable event! Choose a location below to get started",
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: AppColors.grey),
                ),
                SizedBox(height: 24),
                TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    fillColor: AppColors.lightGrey,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.location_on),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (_locationController.text.isNotEmpty) {
                          cubit.addLocation(_locationController.text);
                          _locationController.clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter a location"),
                            ),
                          );
                        }
                      },
                      icon: Icon(Icons.add),
                    ),
                    suffixIconColor: AppColors.grey,
                    prefixIconColor: AppColors.grey,
                    hintText: "Add your location: city, country",
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "Select your location",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<ChooseLocationCubit, ChooseLocationState>(
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      current is FetchedLocations ||
                      current is FetchingLocations ||
                      current is FetchLocationFailure,
                  builder: (context, state) {
                    if (state is FetchingLocations) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (state is FetchedLocations) {
                      final dummyLocations = state.locations;
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dummyLocations.length,
                        itemBuilder: (context, index) {
                          final location = dummyLocations[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child:
                                BlocBuilder<
                                  ChooseLocationCubit,
                                  ChooseLocationState
                                >(
                                  bloc: cubit,
                                  buildWhen: (previous, current) =>
                                      current is LocationChosen,
                                  builder: (context, state) {
                                    if (state is LocationChosen) {
                                      final chosenLocation = state.location;
                                      return LocationItemWidget(
                                        onTap: () {
                                          cubit.selectLocation(location.id);
                                        },
                                        location: location,
                                        borderColor:
                                            chosenLocation.id == location.id
                                            ? AppColors.primary
                                            : AppColors.grey,
                                      );
                                    }
                                    return LocationItemWidget(
                                      onTap: () {
                                        cubit.selectLocation(location.id);
                                      },
                                      location: location,
                                    );
                                  },
                                ),
                          );
                        },
                      );
                    } else if (state is FetchLocationFailure) {
                      return Center(child: Text(state.message));
                    } else {
                      return Container();
                    }
                  },
                ),
                SizedBox(height: 24),
                BlocConsumer<ChooseLocationCubit, ChooseLocationState>(
                  listenWhen: (previous, current) =>
                      current is ConfirmLocationLoaded,
                  listener: (context, state) {
                    if (state is ConfirmLocationLoaded) {
                      Navigator.of(context).pop();
                    }
                  },
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      current is ConfirmLocationLoaded ||
                      current is ConfirmLocationLoading ||
                      current is ConfirmLocationFailure,
                  builder: (context, state) {
                    if (state is ConfirmLocationLoading) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    return MainButton(
                      text: "Confirm",
                      onTap: () {
                        cubit.confirmLocation();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
