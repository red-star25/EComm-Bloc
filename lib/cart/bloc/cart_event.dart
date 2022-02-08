part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartProductFetchEvent extends CartEvent {}

class CartProductQuantityChangedEvent extends CartEvent {
  CartProductQuantityChangedEvent({
    required this.product,
    required this.quantity,
  });
  final Product product;
  final int quantity;
}

class CartProductDeleteEvent extends CartEvent {
  CartProductDeleteEvent({required this.id});
  final String id;
}
