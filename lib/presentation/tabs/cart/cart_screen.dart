import 'package:flutter/material.dart';
import 'package:third_exam/data/local_data/db/cached_category.dart';
import 'package:third_exam/data/models/product_item.dart';
import 'package:third_exam/data/my_repository.dart';
import 'package:third_exam/utils/colors.dart';
import 'package:third_exam/utils/styles.dart';
import 'package:third_exam/utils/utility_functions.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, required this.myRepository}) : super(key: key);

  final MyRepository myRepository;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CachedProduct> products = [];
  int totalPrice = 0;
  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    products = await MyRepository.getAllBaskletProducts();
    totalPrice = products
        .map((e) => (e.price * e.count))
        .reduce((value, element) => value + element);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Savatcha"),
        actions: [
          TextButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                          "Rostdan ham savatchadi barcha mahsulotlarni o'chirmoqchimisiz?"),
                      actions: [
                        TextButton(
                          child: const Text('Ha'),
                          onPressed: () async {
                            //TODO 11 Barcha Savatga saqlangan mahsulotlar o'chirilsin!
                            MyRepository.deleteAllBasketProduct();
                            _init();
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text("Yo'q"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
            child: Text(
              "Tozalash",
              style: MyTextStyle.interSemiBold600.copyWith(
                color: MyColors.white,
              ),
            ),
          )
        ],
      ),
      //TODO 10 FutureBuilder widgetidan foydalanib saqlangan mahsulotlar chaqirib ekranga chizilsin!
      //TODO 15 Har bir savatga saqlangan mahsulotni foydalanuvchi o'chirish imkoniga ega bo'lsin!
      //TODO 16 Savatga saqlangan mahsulotlarni umumiy narxini ekranga chiqaring!
      body: products.isEmpty
          ? const Center(
              child: Text("Basket is Empty"),
            )
          : Stack(
              children: [
                ListView(
                  children: List.generate(
                    products.length,
                    (index) => Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 75,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(products[index].name),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Maxsulotlar soni: ${products[index].count.toString()} x ${products[index].price}",
                                  style: const TextStyle(
                                      color: MyColors.C_4047C1, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              products[index].imageUrl,
                              width: 70,
                              height: 70,
                              fit: BoxFit.contain,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              MyRepository.deleteCachedTodById(
                                  id: products[index].id!);

                              _init();
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: MyColors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
                  child: Container(
                    width: 350,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: MyColors.grey,
                            blurRadius: 5,
                            spreadRadius: 0.5,
                            offset: (Offset(0.1, 0.1))),
                      ],
                    ),
                    child: Center(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Umumiy Summa ---> ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          " \$ $totalPrice",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: MyColors.C_4047C1),
                        ),
                      ],
                    )),
                  ),
                ),
              ],
            ),
    );
  }
}
