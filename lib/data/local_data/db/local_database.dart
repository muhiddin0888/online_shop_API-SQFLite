import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:third_exam/data/local_data/db/cached_category.dart';

import 'favorite_cached_category.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();
  static Database? _database;

  factory LocalDatabase() {
    return getInstance;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("todos.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  LocalDatabase._init();

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";
    const doubleType = "REAL DEFAULT 0.0";

    await db.execute('''
    CREATE TABLE $productsTable (
    ${ProductFields.id} $idType,
    ${ProductFields.count} $intType,
    ${ProductFields.productId} $intType,
    ${ProductFields.imageUrl} $textType,
    ${ProductFields.name} $textType,
    ${ProductFields.price} $intType
    )
    ''');

    await db.execute('''
    CREATE TABLE $favoriteTable (
    ${ProductFields.id} $idType,
    ${ProductFields.productId} $intType,
    ${ProductFields.imageUrl} $textType,
    ${ProductFields.name} $textType,
    ${ProductFields.price} $intType
    )
    ''');
  }

  //-------------------Cached Products Table-------------------
  static Future<CachedProduct> insertProduct(
      CachedProduct cachedCategory) async {
    final db = await getInstance.database;
    final id = await db.insert(productsTable, cachedCategory.toJson());
    return cachedCategory.copyWith(id: id);
  }

  static Future<List<CachedProduct>> getAllBaskletProducts() async {
    final db = await getInstance.database;
    final result = await db.query(
      productsTable,
    );
    return result.map((json) => CachedProduct.fromJson(json)).toList();
  }

  static Future<int> deleteCachedCategoryById(int id) async {
    final db = await getInstance.database;
    var t = await db
        .delete(productsTable, where: "${ProductFields.id}=?", whereArgs: [id]);
    if (t > 0) {
      return t;
    } else {
      return -1;
    }
  }

  static Future<int> updateProduct(
      {required int id, required CachedProduct cachedCategory}) async {
    Map<String, dynamic> row = {
      ProductFields.count: cachedCategory.count,
      ProductFields.imageUrl: cachedCategory.imageUrl,
      ProductFields.price: cachedCategory.price,
      ProductFields.name: cachedCategory.name,
      ProductFields.productId: cachedCategory.productId,
    };

    final db = await getInstance.database;
    return await db.update(
      productsTable,
      row,
      where: '${ProductFields.id} = ?',
      whereArgs: [id],
    );
  }

  static Future<int> deleteAllBasketProduct() async {
    final db = await getInstance.database;
    return await db.delete(productsTable);
  }

  static Future<int> deleteById(int id) async {
    final db = await getInstance.database;
    var t = await db
        .delete(productsTable, where: "${ProductFields.id}=?", whereArgs: [id]);
    if (t > 0) {
      return t;
    } else {
      return -1;
    }
  }

  //-------------------Favorite Products Table-------------------

  static Future<FavoriteCachedProduct> insertFavoriteProduct(
      FavoriteCachedProduct favoriteCachedProduct) async {
    final db = await getInstance.database;
    final id = await db.insert(favoriteTable, favoriteCachedProduct.toJson());
    return favoriteCachedProduct.copyWith(id: id);
  }

  static Future<List<FavoriteCachedProduct>> getAllFavoriteProducts() async {
    final db = await getInstance.database;
    final result = await db.query(
      favoriteTable,
    );
    return result.map((json) => FavoriteCachedProduct.fromJson(json)).toList();
  }

  static Future<int> deleteFavoriteProductById(int id) async {
    final db = await getInstance.database;
    var t = await db.delete(favoriteTable,
        where: "${FavoriteProductFields.id}=?", whereArgs: [id]);
    if (t > 0) {
      return t;
    } else {
      return -1;
    }
  }

  static Future<int> updateFavoriteProduct(
      {required int id,
      required FavoriteCachedProduct favoriteCachedProduct}) async {
    Map<String, dynamic> row = {
      FavoriteProductFields.imageUrl: favoriteCachedProduct.imageUrl,
      FavoriteProductFields.price: favoriteCachedProduct.price,
      FavoriteProductFields.name: favoriteCachedProduct.name,
      FavoriteProductFields.productId: favoriteCachedProduct.productId,
    };

    final db = await getInstance.database;
    return await db.update(
      favoriteTable,
      row,
      where: '${FavoriteProductFields.id} = ?',
      whereArgs: [id],
    );
  }

  static Future<int> deleteAllFavoriteProduct() async {
    final db = await getInstance.database;
    return await db.delete(favoriteTable);
  }

  static Future<int> deleteFavoriteById(int id) async {
    final db = await getInstance.database;
    var t = await db.delete(favoriteTable,
        where: "${FavoriteProductFields.id}=?", whereArgs: [id]);
    if (t > 0) {
      return t;
    } else {
      return -1;
    }
  }
}
