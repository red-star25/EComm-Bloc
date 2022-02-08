import 'package:ecomm/cart/bloc/cart_bloc.dart';
import 'package:ecomm/cart/data/model/cart_product.dart';
import 'package:ecomm/cart/widget/quantity_bottom_sheet.dart';
import 'package:ecomm/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuantityAndDelete extends StatelessWidget {
  const QuantityAndDelete({
    Key? key,
    required this.cartProduct,
    required this.index,
    required this.quantityController,
  }) : super(key: key);
  final CartProduct cartProduct;
  final int index;
  final TextEditingController quantityController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quantity: '),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  cartProduct.quantity.toString(),
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    size: 18,
                  ),
                  onPressed: () {
                    buildBottomSheet(
                      context,
                      cartProduct,
                      quantityController,
                    );
                  },
                ),
              ],
            ),
            //delete icon
            IconButton(
              icon: const Icon(
                Icons.delete,
                size: 20,
                color: AppColors.buttonColor,
              ),
              onPressed: () {
                BlocProvider.of<CartBloc>(context).add(
                  CartProductDeleteEvent(
                    id: cartProduct.id,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
