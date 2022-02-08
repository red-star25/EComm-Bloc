import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    Key? key,
    required this.productSubtitle,
    required this.productTitle,
  }) : super(key: key);
  final String productTitle;
  final String productSubtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productTitle,
          style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: 20,
              ),
        ),
        Text(
          productSubtitle,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}
