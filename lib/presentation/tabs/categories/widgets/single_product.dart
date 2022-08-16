import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class SingleProduct extends StatelessWidget {
  const SingleProduct(
      {super.key,
      required this.name,
      required this.price,
      required this.images,
      required this.onTap});
  final String name;
  final int price;
  final String images;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColors.white,
        boxShadow: const [
          BoxShadow(
              color: MyColors.grey,
              blurRadius: 5,
              spreadRadius: 0.5,
              offset: (Offset(0.1, 0.1))),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            images,
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Center(
            child: Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          "USD ${price.toString()}",
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: MyColors.C_4047C1),
          maxLines: 1,
        ),
        TextButton(
          onPressed: onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: MyColors.black, borderRadius: BorderRadius.circular(8)),
            child: const Text(
              "Savatga qo'shish",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: MyColors.white),
            ),
          ),
        ),
      ]),
    );
  }
}
