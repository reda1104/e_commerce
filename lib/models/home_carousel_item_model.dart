// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HomeCarouselItemModel {
  String id;
  String imgUrl;

  HomeCarouselItemModel({required this.id, required this.imgUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'imgUrl': imgUrl};
  }

  factory HomeCarouselItemModel.fromMap(Map<String, dynamic> map) {
    return HomeCarouselItemModel(
      id: map['id'] as String,
      imgUrl: map['imgUrl'] as String,
    );
  }
}

List<HomeCarouselItemModel> dummyHomeCarouselItems = [
  HomeCarouselItemModel(
    id: '1',
    imgUrl:
        'https://img.freepik.com/premium-vector/online-shopping-background-with-colorful-credit-card-illustrations_269039-170.jpg?w=740',
  ),
  HomeCarouselItemModel(
    id: '2',
    imgUrl:
        'https://img.freepik.com/premium-vector/website-mobile-phone-design-online-shopping-store_212216-1010.jpg',
  ),
  HomeCarouselItemModel(
    id: '3',
    imgUrl:
        'https://img.freepik.com/free-vector/online-shopping-background-with-3d-illustrations-mobile-phones-shopping-bags_269039-168.jpg?size=626&ext=jpg',
  ),
];
