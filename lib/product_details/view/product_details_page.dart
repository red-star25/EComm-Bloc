import 'package:ecomm/constants/colors.dart';
import 'package:ecomm/data/repository/app_repository.dart';
import 'package:ecomm/home/data/models/product.dart';
import 'package:ecomm/product_details/bloc/productview_bloc.dart';
import 'package:ecomm/product_details/data/repository/product_view_repository.dart';
import 'package:ecomm/product_details/widgets/image_and_price.dart';
import 'package:ecomm/product_details/widgets/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return RepositoryProvider(
      create: (context) => ProductViewRepository(),
      child: BlocProvider(
        create: (context) => ProductviewBloc(
          productViewRepository:
              RepositoryProvider.of<ProductViewRepository>(context),
          appRepository: RepositoryProvider.of<AppRepository>(context),
        )..add(ProductIdsFetchFromCartEvent()),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<ProductviewBloc, ProductviewState>(
            builder: (context, state) {
              if (state is ProductViewLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProductIdsFetchFromCartSuccess) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const BackButton(),
                            const SizedBox(
                              width: 10,
                            ),
                            ProductImageAndPrice(data: data)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ProductInfo(
                          data: data,
                          listOfProductIds: state.productIds,
                        ),
                        if (!state.productIds
                            .contains((data['data'] as Product).id))
                          Align(
                            child: GestureDetector(
                              onTap: () {
                                context.read<ProductviewBloc>().add(
                                      ProductAddedToCartEvent(
                                        productId: (data['data'] as Product).id,
                                      ),
                                    );
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: const BoxDecoration(
                                  color: AppColors.buttonColor,
                                ),
                                child: Center(
                                  child: Text(
                                    'Add to cart',
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                              ),
                            ),
                          )
                        else
                          Align(
                            child: GestureDetector(
                              onTap: () {
                                context.read<ProductviewBloc>().add(
                                      ProductRemoveFromCart(
                                        productId: (data['data'] as Product).id,
                                      ),
                                    );
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: const BoxDecoration(
                                  color: AppColors.buttonColor,
                                ),
                                child: Center(
                                  child: Text(
                                    'Remove from cart',
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                );
              }
              if (state is ProductViewError) {
                return const Center(
                  child: Text('Error'),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
