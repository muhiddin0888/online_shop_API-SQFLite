import 'package:flutter/material.dart';
import 'package:third_exam/data/api/api_provider.dart';
import 'package:third_exam/data/models/category_item.dart';
import 'package:third_exam/data/my_repository.dart';
import 'package:third_exam/presentation/products/products_screen.dart';
import 'package:third_exam/presentation/tabs/categories/widgets/all_category_card.dart';
import 'package:third_exam/presentation/tabs/categories/widgets/category_item_view.dart';
import 'package:third_exam/presentation/tabs/categories/get_single_product.dart';
import 'package:third_exam/utils/colors.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key, required this.myRepository})
      : super(key: key);

  final MyRepository myRepository;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kategoryalar"),
      ),
      //TODO 8 FutureBuilder widget idan foydalanib barcha kategoriyalar chaqirilib ekranga chizilsin!
      body: FutureBuilder(
          future: ApiProvider.getAllCategory(),
          builder: (context, AsyncSnapshot<List<CategoryItem>> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data!;
              return ListView(
                children: List.generate(
                    data.length,
                    (index) => AllCategoryCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return SingleCategoryProduct(
                                  categoryItem: data[index],
                                );
                              }),
                            );
                          },
                          name: data[index].name,
                          images: data[index].imageUrl,
                        )),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
