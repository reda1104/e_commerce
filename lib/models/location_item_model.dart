// ignore_for_file: public_member_api_docs, sort_constructors_first
class LocationItemModel {
  final String id;
  final String city;
  final String country;
  final String imgUrl;
  final bool isChosen;

  LocationItemModel({
    required this.id,
    required this.city,
    required this.country,
    this.isChosen = false,
    this.imgUrl =
        "https://img.freepik.com/premium-vector/gps-map-navigator-concept-street-maps-directions-vector-illustration_230920-2779.jpg?w=2000",
  });

  LocationItemModel copyWith({
    String? id,
    String? city,
    String? country,
    String? imgUrl,
    bool? isChosen,
  }) {
    return LocationItemModel(
      id: id ?? this.id,
      city: city ?? this.city,
      country: country ?? this.country,
      imgUrl: imgUrl ?? this.imgUrl,
      isChosen: isChosen ?? this.isChosen,
    );
  }
}

List<LocationItemModel> dummyLocations = [
  LocationItemModel(id: '1', city: 'New York', country: 'United States'),
  LocationItemModel(id: '2', city: 'Paris', country: 'France'),
  LocationItemModel(id: '3', city: 'London', country: 'United Kingdom'),
];
