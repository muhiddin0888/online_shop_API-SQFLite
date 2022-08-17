import 'package:flutter/material.dart';
import 'package:third_exam/data/models/category_item.dart';
import 'package:third_exam/data/my_repository.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen(
      {Key? key, required this.myRepository, required this.categoryItem})
      : super(key: key);

  final MyRepository myRepository;
  final CategoryItem categoryItem;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mahsulotlar"),
      ),
      body: Container(),
    );
  }
}
