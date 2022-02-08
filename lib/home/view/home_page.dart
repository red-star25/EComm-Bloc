import 'package:ecomm/home/bloc/home_bloc.dart';
import 'package:ecomm/home/data/models/product.dart';
import 'package:ecomm/home/home.dart';
import 'package:ecomm/home/widgets/home_appbar.dart';
import 'package:ecomm/home/widgets/home_product_grid.dart';
import 'package:ecomm/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void notifyUpdateIsFavourite() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(HomeEventFetch());
    return Scaffold(
      bottomNavigationBar: BottomNav(
        currentIndex: 0,
      ),
      appBar: HomeAppBar(
        appBar: AppBar(),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is HomeError) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is HomeLoaded) {
            return StreamBuilder(
              stream: state.products,
              builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 18,
                      right: 18,
                      top: 28,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DISCOVER',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: 35),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        HomeProductGrid(
                          data: snapshot.data!,
                          notifyUpdateIsFavourite: notifyUpdateIsFavourite,
                        )
                      ],
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
