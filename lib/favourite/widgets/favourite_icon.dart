import 'package:ecomm/favourite/favourite.dart';
import 'package:ecomm/home/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({Key? key, required this.data, required this.index})
      : super(key: key);

  final List<Product> data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 14,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            data[index].price,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<FavouriteBloc>(
                context,
              ).add(
                FavouriteEventRemove(
                  context: context,
                  id: data[index].id,
                ),
              );
              BlocProvider.of<FavouriteBloc>(
                context,
              ).add(
                FavouriteEventFetch(),
              );
            },
            child: const Icon(
              Icons.favorite,
            ),
          ),
        ],
      ),
    );
  }
}
