import 'package:ecomm/cart/bloc/cart_bloc.dart';
import 'package:ecomm/cart/data/model/cart_product.dart';
import 'package:ecomm/constants/colors.dart';
import 'package:ecomm/home/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> buildBottomSheet(
  BuildContext context,
  CartProduct cartProduct,
  TextEditingController quantityController,
) {
  return showModalBottomSheet<void>(
    isScrollControlled: true,
    isDismissible: true,
    context: context,
    builder: (BuildContext sheetContext) {
      return Padding(
        padding: MediaQuery.of(sheetContext).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Please add quantity',
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Quantity',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                        sheetContext,
                      );
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final cartMapData = cartProduct.toMap();
                      final product = Product.fromMap(
                        cartMapData,
                      );
                      BlocProvider.of<CartBloc>(context).add(
                        CartProductQuantityChangedEvent(
                          quantity: int.parse(
                            quantityController.text,
                          ),
                          product: product,
                        ),
                      );
                      Navigator.pop(
                        sheetContext,
                      );
                    },
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
