import 'package:flutter/material.dart';
import 'package:third_exam/data/local_data/db/favorite_cached_category.dart';
import 'package:third_exam/data/models/all_product_item.dart';
import 'package:third_exam/data/models/product_item.dart';
import 'package:third_exam/presentation/tabs/all_products/favorite_list_screen.dart';
import 'package:third_exam/presentation/tabs/all_products/widget/single_card_item.dart';
import 'package:third_exam/utils/colors.dart';
import '../../../data/api/api_provider.dart';
import '../../../data/local_data/db/cached_category.dart';
import '../../../data/my_repository.dart';
import '../../../utils/utility_functions.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key, required this.myRepository});
  final MyRepository myRepository;

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  bool isFvorite = false;
  List<FavoriteCachedProduct> products = [];
  List<FavoriteCachedProduct> favourites = [];

  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    products = await MyRepository.getAllFavoriteProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hamma mahsulotlar"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return FavoriteScreen(
                    myRepository: MyRepository(apiProvider: ApiProvider()));
              }));
            },
            icon: Icon(
              Icons.favorite,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: Future.wait([
            ApiProvider.getAllProductList(),
            MyRepository.getAllFavoriteProducts()
          ]),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            } else if (snapshot.hasData) {
              favourites = snapshot.data[1]! as List<FavoriteCachedProduct>;
              var data = snapshot.data[0]! as List<AllProductItem>;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => FavorSingleItem(
                    isfavourite: favourites
                        .map((e) => e.productId)
                        .toList()
                        .contains(data[index].id),
                    images: data[index].imageUrl,
                    name: data[index].name,
                    price: data[index].price,
                    onTapFavor: () async {
                      var list = favourites
                          .map((e) => e.productId == data[index].id)
                          .toList();
                      if (favourites
                          .map((e) => e.productId)
                          .toList()
                          .contains(data[index].id)) {
                        MyRepository.deleteFavoriteById(
                            id: favourites
                                .where((element) =>
                                    element.productId == data[index].id)
                                .toList()[0]
                                .id!);
                      } else {
                        FavoriteCachedProduct favoriteCachedProduct =
                            FavoriteCachedProduct(
                                imageUrl: data[index].imageUrl,
                                price: data[index].price,
                                name: data[index].name,
                                productId: data[index].id);
                        await MyRepository.insertFavoriteProducts(
                            favoriteCachedProduct: favoriteCachedProduct);
                        UtilityFunctions.getMyToast(
                            message: "Sevimliga Qo'shildi");
                      }
                      setState(() {});
                    },
                    onTap: () async {
                      String name = data[index].name;
                      String images = data[index].imageUrl;
                      int id = data[index].id;
                      int price = data[index].price;
                      var allPrpducts =
                          await MyRepository.getAllBaskletProducts();
                      bool beforeSved = false;
                      int savedId = 0;
                      int count = 0;
                      allPrpducts.forEach((element) {
                        if (data[index].id == element.productId) {
                          beforeSved = true;
                          count = element.count;
                          savedId = element.id!;
                        }
                      });
                      if (beforeSved) {
                        count += 1;
                        CachedProduct cachedProduct = CachedProduct(
                            imageUrl: images,
                            price: price,
                            count: count,
                            name: name,
                            productId: savedId);
                        MyRepository.updateProduct(
                            id: savedId, cachedProduct: cachedProduct);
                        UtilityFunctions.getMyToast(
                            message: "Savatch Yangilandi");
                      } else {
                        CachedProduct cachedProduct = CachedProduct(
                            imageUrl: images,
                            price: price,
                            count: 1,
                            name: name,
                            productId: id);
                        await MyRepository.insertProducts(
                            cachedProduct: cachedProduct);
                        UtilityFunctions.getMyToast(
                            message: "Savatch Qo'shildi");
                      }
                    },
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    childAspectRatio: 0.59,
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  bool isFavoriteProduct(FavoriteCachedProduct item) =>
      favourites.map((e) => e.productId).toList().contains(item.id);
}
