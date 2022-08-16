const String favoriteTable = "favorite_products";

class FavoriteProductFields {
  static final List<String> values = [
    /// Add all fields
    name, price, imageUrl,
  ];
  static const String id = "_id";
  static const String productId = "product_id";
  static const String name = "name";
  static const String price = "price";
  static const String imageUrl = "image_url";
}

class FavoriteCachedProduct {
  final int? id;
  final int productId;
  final String name;
  final int price;
  final String imageUrl;

  FavoriteCachedProduct({
    this.id,
    required this.imageUrl,
    required this.price,
    required this.name,
    required this.productId,
  });

  FavoriteCachedProduct copyWith({
    int? id,
    int? productId,
    int? price,
    String? name,
    String? imageUrl,
  }) =>
      FavoriteCachedProduct(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        price: price ?? this.price,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  static FavoriteCachedProduct fromJson(Map<String, Object?> json) =>
      FavoriteCachedProduct(
        id: json[FavoriteProductFields.id] as int?,
        productId: json[FavoriteProductFields.productId] as int,
        price: json[FavoriteProductFields.price] as int,
        name: json[FavoriteProductFields.name] as String,
        imageUrl: json[FavoriteProductFields.imageUrl] as String,
      );

  Map<String, Object?> toJson() => {
        FavoriteProductFields.id: id,
        FavoriteProductFields.productId: productId,
        FavoriteProductFields.price: price,
        FavoriteProductFields.name: name,
        FavoriteProductFields.imageUrl: imageUrl,
      };

  @override
  String toString() => '''
        ID: $id 
        RODUCT ID $productId
        PRICE $price
        NAME $name
        IMAGE URL $imageUrl
      ''';
}
