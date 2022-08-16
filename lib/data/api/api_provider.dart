import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:http/http.dart';
import 'package:third_exam/data/models/category_item.dart';
import 'package:third_exam/data/models/product_item.dart';

import '../models/all_product_item.dart';

class ApiProvider {
  // ------------------------- Get All Categories -----------------------------

  static Future<List<CategoryItem>> getAllCategory() async {
    try {
      Response response = await https.get(
        Uri.parse("https://third-exam.free.mockoapp.net/categories"),
      );
      if (response.statusCode == 200) {
        List<CategoryItem> products = (jsonDecode(response.body) as List)
            .map((item) => CategoryItem.fromJson(item))
            .toList();
        return products;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    } finally {}
  }

  //TODO 4 barcha Categoryalarni  serverdan olib keluvchi so'rov yozilsin!

  // ------------------------- Get Single Category Products -----------------------------

  static Future<List<ProductItem>> getAllProducts(
      {required int productId}) async {
    try {
      Response response = await https.get(
        Uri.parse("https://third-exam.free.mockoapp.net/categories/$productId"),
      );
      if (response.statusCode == 200) {
        List<ProductItem> products = (jsonDecode(response.body) as List)
            .map((item) => ProductItem.fromJson(item))
            .toList();
        return products;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    } finally {}
  }

  // ------------------------- Get All Products -----------------------------

  static Future<List<AllProductItem>> getAllProductList() async {
    try {
      Response response = await https.get(
        Uri.parse("https://third-exam.free.mockoapp.net/products"),
      );
      if (response.statusCode == 200) {
        List<AllProductItem> products = (jsonDecode(response.body) as List)
            .map((item) => AllProductItem.fromJson(item))
            .toList();
        return products;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    } finally {}
  }
}
