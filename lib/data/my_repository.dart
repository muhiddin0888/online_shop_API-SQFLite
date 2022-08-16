import 'package:third_exam/data/api/api_provider.dart';
import 'package:third_exam/data/local_data/db/favorite_cached_category.dart';

import 'local_data/db/cached_category.dart';
import 'local_data/db/local_database.dart';

class MyRepository {
  MyRepository({
    required this.apiProvider,
  });

  final ApiProvider apiProvider;

  //TODO 6 apiProvider klasi ichidagi metodlar chaqirib MyRepository klasi obyektiga qo'shilsin!

//  -----------------------------------Products------------------------------------------
  static Future<CachedProduct> insertProducts(
      {required CachedProduct cachedProduct}) async {
    return await LocalDatabase.insertProduct(cachedProduct);
  }

  static Future<List<CachedProduct>> getAllBaskletProducts() async {
    return await LocalDatabase.getAllBaskletProducts();
  }

  static Future<int> updateProduct(
      {required int id, required CachedProduct cachedProduct}) async {
    return await LocalDatabase.updateProduct(
        id: id, cachedCategory: cachedProduct);
  }

  static Future<int> deleteAllBasketProduct() async {
    return await LocalDatabase.deleteAllBasketProduct();
  }

  static Future<int> deleteCachedTodById({required int id}) async {
    return await LocalDatabase.deleteById(id);
  }

  //  -----------------------------------Favorite------------------------------------------
  static Future<FavoriteCachedProduct> insertFavoriteProducts(
      {required FavoriteCachedProduct favoriteCachedProduct}) async {
    return await LocalDatabase.insertFavoriteProduct(favoriteCachedProduct);
  }

  static Future<List<FavoriteCachedProduct>> getAllFavoriteProducts() async {
    return await LocalDatabase.getAllFavoriteProducts();
  }

  static Future<int> updateFavoriteProduct(
      {required int id,
      required FavoriteCachedProduct favoriteCachedProduct}) async {
    return await LocalDatabase.updateFavoriteProduct(
        id: id, favoriteCachedProduct: favoriteCachedProduct);
  }

  static Future<int> deleteAllFavoriteProduct() async {
    return await LocalDatabase.deleteAllFavoriteProduct();
  }

  static Future<int> deleteFavoriteById({required int id}) async {
    return await LocalDatabase.deleteFavoriteById(id);
  }
}
