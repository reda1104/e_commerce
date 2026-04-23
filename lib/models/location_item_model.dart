class LocationItemModel {
  final String id;
  final String city;
  final String country;
  final String imgUrl;

  LocationItemModel({
    required this.id,
    required this.city,
    required this.country,
    this.imgUrl =
        "https://img.freepik.com/premium-vector/gps-map-navigator-concept-street-maps-directions-vector-illustration_230920-2779.jpg?w=2000",
  });
}

List<LocationItemModel> dummyLocations = [
  LocationItemModel(id: '1', city: 'New York', country: 'United States'),
  LocationItemModel(id: '2', city: 'Paris', country: 'France'),
  LocationItemModel(id: '3', city: 'London', country: 'United Kingdom'),
];
