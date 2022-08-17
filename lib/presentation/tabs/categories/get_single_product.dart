import 'dart:math';

import 'package:flutter/material.dart';
import 'package:third_exam/data/models/category_item.dart';
import 'package:third_exam/data/models/product_item.dart';
import 'package:third_exam/presentation/tabs/categories/widgets/single_product.dart';
import 'package:third_exam/utils/colors.dart';

import '../../../data/api/api_provider.dart';
import '../../../data/local_data/db/cached_category.dart';
import '../../../data/my_repository.dart';
import '../../../utils/utility_functions.dart';

class SingleCategoryProduct extends StatelessWidget {
  const SingleCategoryProduct({super.key, required this.categoryItem});
  final CategoryItem categoryItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryItem.name),
      ),
      body: FutureBuilder(
          future: ApiProvider.getAllProducts(productId: categoryItem.id),
          builder: (context, AsyncSnapshot<List<ProductItem>> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: _allProductsView(data),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  // ALL PRODUCTS IN GRIDVIEW
  GridView _allProductsView(List<ProductItem> data) {
    return GridView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => SingleProduct(
        images: data[index].imageUrl,
        name: data[index].name,
        price: data[index].price,
        onTap: () async {
          String name = data[index].name;
          String images = data[index].imageUrl;
          int id = data[index].id;
          int price = data[index].price;
          var allPrpducts = await MyRepository.getAllBaskletProducts();
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
            UtilityFunctions.getMyToast(message: "Savatch Yangilandi");
          } else {
            CachedProduct cachedProduct = CachedProduct(
                imageUrl: images,
                price: price,
                count: 1,
                name: name,
                productId: id);
            await MyRepository.insertProducts(cachedProduct: cachedProduct);
            UtilityFunctions.getMyToast(message: "Savatch Qo'shildi");

            Navigator.pop(context);
          }
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 0.5,
      ),
    );
  }
}
