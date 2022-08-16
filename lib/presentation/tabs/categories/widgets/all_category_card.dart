import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class AllCategoryCard extends StatelessWidget {
  const AllCategoryCard(
      {super.key,
      required this.images,
      required this.name,
      required this.onTap});
  final String images;
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                images,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
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
          ],
        ),
      ),
    );
  }
}
