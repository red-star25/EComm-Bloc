import 'package:ecomm/auth/auth.dart';
import 'package:ecomm/cart/bloc/cart_bloc.dart';
import 'package:ecomm/cart/data/repository/cart_repository.dart';
import 'package:ecomm/constants/app_theme.dart';
import 'package:ecomm/data/repository/app_repository.dart';
import 'package:ecomm/favourite/favourite.dart';
import 'package:ecomm/home/home.dart';
import 'package:ecomm/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppRepository>(
          create: (context) => AppRepository(),
        ),
        RepositoryProvider<HomeRepository>(
          create: (context) => HomeRepository(),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<CartRepository>(
          create: (context) => CartRepository(),
        ),
        RepositoryProvider<FavouriteRepository>(
          create: (context) => FavouriteRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
              appRepository: RepositoryProvider.of<AppRepository>(context),
            ),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(
              RepositoryProvider.of<HomeRepository>(context),
            ),
          ),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(
              cartRepository: RepositoryProvider.of<CartRepository>(context),
              appRepository: RepositoryProvider.of<AppRepository>(context),
            ),
          ),
          BlocProvider<FavouriteBloc>(
            create: (context) => FavouriteBloc(
              RepositoryProvider.of<FavouriteRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          theme: themeData,
          initialRoute: '/',
          routes: AppRoutes.routes,
        ),
      ),
    );
  }
}
