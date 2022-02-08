import 'package:ecomm/cart/bloc/cart_bloc.dart';
import 'package:ecomm/cart/widget/checkout_btn.dart';
import 'package:ecomm/cart/widget/quantity_and_delete.dart';
import 'package:ecomm/home/data/models/product.dart';
import 'package:ecomm/home/widgets/product_image.dart';
import 'package:ecomm/home/widgets/product_info.dart';
import 'package:ecomm/payment/paytmconfig.dart';
import 'package:ecomm/widgets/appbar.dart';
import 'package:ecomm/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);
  final quantityController = TextEditingController();
  final paytmConfig = PaytmConfig();

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(CartProductFetchEvent());
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is CartError) {
          return Scaffold(
            body: Center(
              child: Text(state.error),
            ),
          );
        }
        if (state is CartLoaded) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: state.cartProducts.isNotEmpty
                ? CheckoutBtn(paytmConfig: paytmConfig)
                : const SizedBox(),
            bottomNavigationBar: BottomNav(
              currentIndex: 2,
            ),
            appBar: GlobalAppBar(
              appBar: AppBar(),
              title: 'Cart',
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                left: 18,
                right: 18,
                top: 18,
              ),
              child: state.cartProducts.isNotEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,
                        childAspectRatio: 0.58,
                      ),
                      itemCount: state.cartProducts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            final cartMapData =
                                state.cartProducts[index].toMap();
                            final product = Product.fromMap(cartMapData);
                            Navigator.pushNamed(
                              context,
                              '/product',
                              arguments: {
                                'index': index,
                                'data': product,
                              },
                            );
                          },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ProductImage(
                                    imageUrl:
                                        state.cartProducts[index].imageUrl,
                                    index: index,
                                  ),
                                  const SizedBox(height: 12),
                                  ProductInfo(
                                    productTitle:
                                        state.cartProducts[index].title,
                                    productSubtitle:
                                        state.cartProducts[index].subtitle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    state.cartProducts[index].price,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  QuantityAndDelete(
                                    index: index,
                                    cartProduct: state.cartProducts[index],
                                    quantityController: quantityController,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text('No Item added to Cart'),
                    ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
