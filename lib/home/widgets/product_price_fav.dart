import 'package:ecomm/constants/colors.dart';
import 'package:ecomm/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPriceAndFav extends StatefulWidget {
  const ProductPriceAndFav({
    Key? key,
    required this.id,
    this.isFavourite,
    required this.price,
    this.isInFavourite,
    required this.notifyUpdateIsFavourite,
  }) : super(key: key);
  final String price;
  final String id;
  final bool? isFavourite;
  final bool? isInFavourite;
  final VoidCallback notifyUpdateIsFavourite;

  @override
  State<ProductPriceAndFav> createState() => _ProductPriceAndFavState();
}

class _ProductPriceAndFavState extends State<ProductPriceAndFav> {
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
            widget.price,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
          ),
          if (widget.isFavourite!)
            GestureDetector(
              onTap: () {
                context.read<HomeBloc>().add(
                      HomeEventFavourite(
                        id: widget.id,
                        isFavourite: false,
                        notifyUpdateIsFavourite: widget.notifyUpdateIsFavourite,
                        context: context,
                      ),
                    );
                setState(() {});
              },
              child: const Icon(
                Icons.favorite,
                color: AppColors.primaryIconColor,
              ),
            )
          else
            GestureDetector(
              onTap: () {
                context.read<HomeBloc>().add(
                      HomeEventFavourite(
                        id: widget.id,
                        isFavourite: true,
                        notifyUpdateIsFavourite: widget.notifyUpdateIsFavourite,
                        context: context,
                      ),
                    );
                setState(() {});
              },
              child: const Icon(
                Icons.favorite_border,
                color: AppColors.primaryIconColor,
              ),
            )
        ],
      ),
    );
  }
}
