import 'package:ecomm/auth/signin/view/signin_page.dart';
import 'package:ecomm/auth/signup/view/signup_page.dart';
import 'package:ecomm/cart/view/cart_page.dart';
import 'package:ecomm/favourite/view/favourite_page.dart';
import 'package:ecomm/home/view/home_page.dart';
import 'package:ecomm/product_details/view/product_details_page.dart';
import 'package:ecomm/splash/view/splash_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (BuildContext context) => const SplashPage(),
    '/signin': (BuildContext context) => const SignInPage(),
    '/signup': (BuildContext context) => const SignUpPage(),
    '/home': (BuildContext context) => const HomePage(),
    '/product': (BuildContext context) => const ProductDetailsPage(),
    '/favourite': (BuildContext context) => const FavouritePage(),
    '/cart': (BuildContext context) => CartPage(),
  };
}
