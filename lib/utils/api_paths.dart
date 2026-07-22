class ApiPaths {
  static String user(String userId) => 'users/$userId';
  static String cartItem(String userId, String cartItemId) =>
      'users/$userId/cart/$cartItemId';
  static String favoriteProduct(String userId, String productId) =>
      'users/$userId/favorites/$productId';
  static String favoriteProducts(String userId) => 'users/$userId/favorites/';
  static String products() => 'products/';
  static String categories() => 'categories/';
  static String announcements() => 'announcements/';
  static String product(String productId) => 'products/$productId';
}
