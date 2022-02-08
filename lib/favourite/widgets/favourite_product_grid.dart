import 'package:ecomm/favourite/widgets/favourite_icon.dart';
import 'package:ecomm/home/data/models/product.dart';
import 'package:ecomm/home/widgets/product_image.dart';
import 'package:ecomm/home/widgets/product_info.dart';
import 'package:flutter/material.dart';

class FavouriteProductGrid extends StatelessWidget {
  const FavouriteProductGrid({Key? key, required this.data}) : super(key: key);

  final List<Product> data;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        childAspectRatio: 0.7,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/product',
              arguments: {'index': index, 'data': data[index]},
            );
          },
          child: SizedBox(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProductImage(
                      imageUrl: data[index].imageUrl,
                      index: index,
                    ),
                    ProductInfo(
                      productTitle: data[index].title,
                      productSubtitle: data[index].subtitle,
                    ),
                    FavouriteIcon(
                      data: data,
                      index: index,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
