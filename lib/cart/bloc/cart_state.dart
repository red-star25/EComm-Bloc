part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  CartLoaded({required this.cartProducts});

  final List<CartProduct> cartProducts;
}

class CartError extends CartState {
  CartError({required this.error});

  final String error;
}

class CartProductQuantityChanged extends CartState {}
