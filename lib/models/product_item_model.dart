enum ProductSizes { S, M, L, XL }

class ProductItemModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final bool isFavorite;
  final String category;
  final double averageRate;

  ProductItemModel({
    required this.id,
    required this.title,
    this.description = "Lorem Ipsum  ",
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isFavorite = false,
    this.averageRate = 4.5,
  });

  get image => null;

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
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      category: category ?? this.category,
      averageRate: averageRate ?? this.averageRate,
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
    imageUrl: "https://pngimg.com/uploads/tshirt/tshirt_PNG5450.png",
  ),
  ProductItemModel(
    id: "2",
    title: "Slim Fit Blue Jeans",
    description:
        "Modern slim-fit jeans made from stretch denim fabric for a stylish and comfortable look.",
    category: "Clothing",
    price: 49,
    imageUrl: "https://pngimg.com/uploads/jeans/jeans_PNG5745.png",
  ),
  ProductItemModel(
    id: "3",
    title: "Wireless Headphones",
    description:
        "High-quality over-ear wireless headphones with deep bass and long battery life.",
    category: "Electronics",
    price: 89,
    imageUrl: "https://pngimg.com/uploads/headphones/headphones_PNG7640.png",
  ),
  ProductItemModel(
    id: "4",
    title: "Smart Fitness Watch",
    description:
        "Track heart rate, steps, and sleep with this sleek and lightweight smart fitness watch.",
    category: "Electronics",
    price: 129,
    imageUrl: "https://pngimg.com/uploads/watches/watches_PNG9856.png",
  ),
  ProductItemModel(
    id: "5",
    title: "Leather Handbag",
    description:
        "Elegant genuine leather handbag with multiple compartments and adjustable strap.",
    category: "Accessories",
    price: 75,
    imageUrl:
        "https://www.pngall.com/wp-content/uploads/2016/04/Women-Bag-PNG-HD.png",
  ),
  ProductItemModel(
    id: "6",
    title: "Running Sport Shoes",
    description:
        "Lightweight and breathable running shoes designed for comfort and performance.",
    category: "Footwear",
    price: 99,
    imageUrl:
        "https://pngimg.com/uploads/running_shoes/running_shoes_PNG5785.png",
  ),
  ProductItemModel(
    id: "7",
    title: "Minimalist Desk Lamp",
    description:
        "Modern desk lamp with energy-efficient LED lighting and clean minimalist design.",
    category: "Home",
    price: 39,
    imageUrl:
        "https://pics.clipartpng.com/Silver_Desk_Lamp_PNG_Clip_Art-2358.png",
  ),
  ProductItemModel(
    id: "8",
    title: "Stainless Steel Water Bottle",
    description:
        "Insulated stainless steel bottle that keeps beverages hot or cold for hours.",
    category: "Lifestyle",
    price: 25,
    imageUrl:
        "https://static.vecteezy.com/system/resources/previews/036/526/955/original/ai-generated-a-stainless-steel-water-bottle-on-a-transparent-background-free-png.png",
  ),
];
