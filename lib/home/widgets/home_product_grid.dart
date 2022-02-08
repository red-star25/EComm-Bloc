import 'package:ecomm/home/data/models/product.dart';
import 'package:ecomm/home/home.dart';
import 'package:ecomm/home/widgets/product_image.dart';
import 'package:ecomm/home/widgets/product_info.dart';
import 'package:ecomm/home/widgets/product_price_fav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeProductGrid extends StatelessWidget {
  const HomeProductGrid({
    Key? key,
    required this.data,
    required this.notifyUpdateIsFavourite,
  }) : super(key: key);
  final List<Product> data;
  final VoidCallback notifyUpdateIsFavourite;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
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
                      FutureBuilder(
                        future: RepositoryProvider.of<HomeRepository>(context)
                            .getFavProductAndCheckIfIsFav(
                          data[index].id,
                          context,
                        ),
                        builder: (
                          context,
                          AsyncSnapshot<List<String>> listOfFavProductIds,
                        ) {
                          if (!listOfFavProductIds.hasData) {
                            return Container();
                          } else {
                            return ProductPriceAndFav(
                              notifyUpdateIsFavourite: notifyUpdateIsFavourite,
                              id: data[index].id,
                              price: data[index].price,
                              isFavourite: listOfFavProductIds.data!.contains(
                                data[index].id,
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
