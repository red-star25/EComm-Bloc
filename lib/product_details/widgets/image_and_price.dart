import 'package:ecomm/constants/colors.dart';
import 'package:ecomm/home/data/models/product.dart';
import 'package:flutter/material.dart';

class ProductImageAndPrice extends StatelessWidget {
  const ProductImageAndPrice({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(200),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Hero(
              tag: 'image${data["index"]}',
              child: Stack(
                children: [
                  Align(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: AppColors.primary.withOpacity(0.5),
                    ),
                  ),
                  Align(
                    child: Image.network(
                      (data['data'] as Product).imageUrl,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 18),
                child: Text(
                  (data['data'] as Product).price,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
