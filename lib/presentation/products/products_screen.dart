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
      //TODO 12 Tegishli kategoriyaga tegishli mahsulotlar ro'yxati GridView shaklida ekranga chizilsin!
      //TODO 13 Mahsulot ustidagi Savatga qo'shish tugmasi bosilganda mahsulotni savatga ya'ni lokal bazaga saqlang!
      //TODO Agar mahsulot oldin saqlangan bo'lsa count maydoni 1 ga oshirilsin va shu mahsulot update qilinsin aks holda jadvalga yangi qo'shilsin!
      //TODO 14 Mahsulot savatga qo'shilgani haqida foydalanuvchiga habar chiqarilsin!
      body: Container(),
    );
  }
}
