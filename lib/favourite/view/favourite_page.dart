import 'package:ecomm/favourite/bloc/favourite_bloc.dart';
import 'package:ecomm/favourite/widgets/favourite_product_grid.dart';
import 'package:ecomm/home/data/models/product.dart';
import 'package:ecomm/widgets/appbar.dart';
import 'package:ecomm/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    context.read<FavouriteBloc>().add(FavouriteEventFetch());
    return Scaffold(
      appBar: GlobalAppBar(
        title: 'Favourite',
        appBar: AppBar(),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: 1,
      ),
      body: BlocBuilder<FavouriteBloc, FavouriteState>(
        builder: (context, state) {
          if (state is FavouriteLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FavouriteError) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is FavouriteLoaded) {
            return FutureBuilder(
              future: state.favouriteProducts,
              builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 18,
                      right: 18,
                      top: 18,
                    ),
                    child: snapshot.data!.isNotEmpty
                        ? FavouriteProductGrid(
                            data: snapshot.data!,
                          )
                        : Center(
                            child: Text(
                              'No Favourite Items',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                  );
                }
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
