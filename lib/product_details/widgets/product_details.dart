import 'package:ecomm/home/data/models/product.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    Key? key,
    required this.data,
    required this.listOfProductIds,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final List<String> listOfProductIds;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (data['data'] as Product).subtitle,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            (data['data'] as Product).title,
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 28),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            (data['data'] as Product).description,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.black),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
