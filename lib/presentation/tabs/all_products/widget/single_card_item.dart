import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class FavorSingleItem extends StatelessWidget {
  const FavorSingleItem(
      {super.key,
      required this.name,
      required this.price,
      required this.images,
      required this.onTap,
      required this.onTapFavor,
      required this.isfavourite});
  final String name;
  final int price;
  final String images;
  final VoidCallback onTap;
  final VoidCallback onTapFavor;
  final bool isfavourite;

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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  images,
                  height: 120,
                  width: 180,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
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
                      color: MyColors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    "Savatga qo'shish",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: MyColors.white),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 120,
            top: 0,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: MyColors.white),
              child: IconButton(
                onPressed: onTapFavor,
                icon: isfavourite
                    ? const Icon(
                        Icons.favorite,
                        color: MyColors.red,
                      )
                    : const Icon(
                        Icons.favorite_outline,
                        color: MyColors.red,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
