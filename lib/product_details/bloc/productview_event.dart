part of 'productview_bloc.dart';

abstract class ProductviewEvent extends Equatable {
  const ProductviewEvent();

  @override
  List<Object> get props => [];
}

class ProductIdsFetchFromCartEvent extends ProductviewEvent {}

class ProductAddedToCartEvent extends ProductviewEvent {
  const ProductAddedToCartEvent({required this.productId});

  final String productId;
}

class ProductRemoveFromCart extends ProductviewEvent {
  const ProductRemoveFromCart({required this.productId});

  final String productId;
}
