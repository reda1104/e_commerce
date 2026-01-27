class ProductItemModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final bool isFavorite;
  final String category;

  ProductItemModel({
    required this.id,
    required this.title,
    this.description = "Lorem Ipsum  ",
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isFavorite = false,
  });
}

List<ProductItemModel> dummyProducts = [
  ProductItemModel(
    id: "1",
    title: "T-shirt 1",
    description: "This is a description for T-shirt 1",
    category: "T-shirts",
    price: 10,
    imageUrl:
        "https://www.pngall.com/wp-content/uploads/2016/04/Women-Bag-PNG-HD.png",
  ),
  ProductItemModel(
    id: "2",
    title: "T-shirt 2",
    description: "This is a description for T-shirt 2",
    category: "T-shirts",
    price: 12,
    imageUrl:
        "https://www.pngall.com/wp-content/uploads/2016/04/Women-Bag-PNG-HD.png",
  ),
  ProductItemModel(
    id: "3",
    title: "T-shirt 3",
    description: "This is a description for T-shirt 3",
    category: "T-shirts",
    price: 15,
    imageUrl:
        "https://www.pngall.com/wp-content/uploads/2016/04/Women-Bag-PNG-HD.png",
  ),
  ProductItemModel(
    id: "4",
    title: "T-shirt 4",
    description: "This is a description for T-shirt 4",
    category: "T-shirts",
    price: 18,
    imageUrl:
        "https://www.pngall.com/wp-content/uploads/2016/04/Women-Bag-PNG-HD.png",
  ),
  ProductItemModel(
    id: "5",
    title: "T-shirt 5",
    description: "This is a description for T-shirt 5",
    category: "T-shirts",
    price: 20,
    imageUrl:
        "https://www.pngall.com/wp-content/uploads/2016/04/Women-Bag-PNG-HD.png",
  ),
  ProductItemModel(
    id: "6",
    title: "T-shirt 6",
    description: "This is a description for T-shirt 6",
    category: "T-shirts",
    price: 22,
    imageUrl:
        "https://www.pngall.com/wp-content/uploads/2016/04/Women-Bag-PNG-HD.png",
  ),
  ProductItemModel(
    id: "7",
    title: "T-shirt 7",
    description: "This is a description for T-shirt 7",
    category: "T-shirts",
    price: 25,
    imageUrl:
        "https://www.pngall.com/wp-content/uploads/2016/04/Women-Bag-PNG-HD.png",
  ),
  ProductItemModel(
    id: "8",
    title: "T-shirt 8",
    description: "This is a description for T-shirt 8",
    category: "T-shirts",
    price: 28,
    imageUrl:
        "https://www.pngall.com/wp-content/uploads/2016/04/Women-Bag-PNG-HD.png",
  ),
];
