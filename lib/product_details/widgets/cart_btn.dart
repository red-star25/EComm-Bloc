import 'package:ecomm/cart/bloc/cart_bloc.dart';
import 'package:ecomm/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductInfoCartBtn extends StatelessWidget {
  const ProductInfoCartBtn(
      {Key? key,
      required this.data,
      required this.isRemove,
      required this.onCartBtnPressed})
      : super(key: key);

  final Map<String, dynamic> data;
  final bool isRemove;
  final Function(bool, BuildContext) onCartBtnPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return Align(
            child: GestureDetector(
              onTap: () {
                onCartBtnPressed(isRemove, context);
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: const BoxDecoration(
                  color: AppColors.buttonColor,
                ),
                child: Center(
                  child: Text(
                    isRemove ? 'Remove from cart' : 'Add to Cart',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
