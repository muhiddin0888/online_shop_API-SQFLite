import 'package:flutter/material.dart';
import 'package:third_exam/data/local_data/db/favorite_cached_category.dart';
import 'package:third_exam/data/my_repository.dart';
import 'package:third_exam/presentation/tabs/categories/widgets/single_product.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key, required this.myRepository})
      : super(key: key);

  final MyRepository myRepository;

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<FavoriteCachedProduct> products = [];
  int totalPrice = 0;
  @override
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
          title: const Text("Savatcha"),
          actions: [
            IconButton(
                onPressed: () {
                  MyRepository.deleteAllFavoriteProduct();
                  _init();
                  setState(() {});
                },
                icon: Icon(Icons.heart_broken_outlined))
          ],
        ),
        body: FutureBuilder(
          future: MyRepository.getAllFavoriteProducts(),
          builder:
              (context, AsyncSnapshot<List<FavoriteCachedProduct>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error"),
              );
            } else if (snapshot.hasData) {
              return GridView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) => SingleProduct(
                    images: products[index].imageUrl,
                    name: products[index].name,
                    price: products[index].price,
                    onTap: () async {}),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 0.5,
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
        // SingleProduct(
        //                 name: products[index].name,
        //                 price: products[index].price,
        //                 images: products[index].imageUrl,
        //                 onTap: () {})),
        // products.isEmpty
        //     ? const Center(
        //         child: Text("Sizda Sevimli mahsulotingiz yoq!"),
        //       )
        //     :
        );
  }
}
