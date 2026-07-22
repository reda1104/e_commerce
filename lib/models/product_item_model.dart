// ignore_for_file: public_member_api_docs, sort_constructors_first

enum ProductSizes {
  S,
  M,
  L,
  XL;

  static ProductSizes fromString(String size) {
    switch (size.toUpperCase()) {
      case "S":
        return ProductSizes.S;
      case "M":
        return ProductSizes.M;
      case "L":
        return ProductSizes.L;
      case "XL":
        return ProductSizes.XL;
      default:
        return ProductSizes.S;
    }
  }
}

class ProductItemModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imgUrl;
  final bool isFavourite;
  final String category;
  final double averageRate;

  ProductItemModel({
    required this.id,
    required this.title,
    this.description = "Lorem Ipsum  ",
    required this.price,
    required this.imgUrl,
    required this.category,
    this.isFavourite = false,
    this.averageRate = 4.5,
  });

  ProductItemModel copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    bool? isFavorite,
    String? category,
    double? averageRate,
    int? quantity,
    ProductSizes? size,
  }) {
    return ProductItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imgUrl: imageUrl ?? this.imgUrl,
      isFavourite: isFavorite ?? this.isFavourite,
      category: category ?? this.category,
      averageRate: averageRate ?? this.averageRate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imgUrl': imgUrl,
      'isFavourite': isFavourite,
      'category': category,
      'averageRate': averageRate,
    };
  }

  factory ProductItemModel.fromMap(Map<String, dynamic> map) {
    return ProductItemModel(
      id: map['id'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      price: map['price'] ?? "",
      imgUrl: map['imgUrl'] ?? "",
      isFavourite: map['isFavourite'] ?? "",
      category: map['category'] ?? "",
      averageRate: map['averageRate'] ?? "",
    );
  }
}

List<ProductItemModel> dummyProducts = [
  ProductItemModel(
    id: "1",
    title: "Classic White Cotton T-Shirt",
    description:
        "Premium 100% cotton T-shirt with a soft touch finish. Designed for everyday comfort and durability.",
    category: "Clothing",
    price: 19,
    imgUrl: "https://pngimg.com/uploads/tshirt/tshirt_PNG5450.png",
  ),
  ProductItemModel(
    id: "2",
    title: "Slim Fit Blue Jeans",
    description:
        "Modern slim-fit jeans made from stretch denim fabric for a stylish and comfortable look.",
    category: "Clothing",
    price: 49,
    imgUrl: "https://pngimg.com/uploads/jeans/jeans_PNG5745.png",
  ),
  ProductItemModel(
    id: "3",
    title: "Wireless Headphones",
    description:
        "High-quality over-ear wireless headphones with deep bass and long battery life.",
    category: "Electronics",
    price: 89,
    imgUrl: "https://pngimg.com/uploads/headphones/headphones_PNG7640.png",
  ),
  ProductItemModel(
    id: "4",
    title: "Smart Fitness Watch",
    description:
        "Track heart rate, steps, and sleep with this sleek and lightweight smart fitness watch.",
    category: "Electronics",
    price: 129,
    imgUrl: "https://pngimg.com/uploads/watches/watches_PNG9856.png",
  ),
  ProductItemModel(
    id: "5",
    title: "Leather Handbag",
    description:
        "Elegant genuine leather handbag with multiple compartments and adjustable strap.",
    category: "Accessories",
    price: 75,
    imgUrl:
        "https://www.pngall.com/wp-content/uploads/2016/04/Women-Bag-PNG-HD.png",
  ),
  ProductItemModel(
    id: "6",
    title: "Running Sport Shoes",
    description:
        "Lightweight and breathable running shoes designed for comfort and performance.",
    category: "Footwear",
    price: 99,
    imgUrl:
        "https://pngimg.com/uploads/running_shoes/running_shoes_PNG5785.png",
  ),
  ProductItemModel(
    id: "7",
    title: "Minimalist Desk Lamp",
    description:
        "Modern desk lamp with energy-efficient LED lighting and clean minimalist design.",
    category: "Home",
    price: 39,
    imgUrl:
        "https://pics.clipartpng.com/Silver_Desk_Lamp_PNG_Clip_Art-2358.png",
  ),
  ProductItemModel(
    id: "8",
    title: "Stainless Steel Water Bottle",
    description:
        "Insulated stainless steel bottle that keeps beverages hot or cold for hours.",
    category: "Lifestyle",
    price: 25,
    imgUrl:
        "https://static.vecteezy.com/system/resources/previews/036/526/955/original/ai-generated-a-stainless-steel-water-bottle-on-a-transparent-background-free-png.png",
  ),
];
