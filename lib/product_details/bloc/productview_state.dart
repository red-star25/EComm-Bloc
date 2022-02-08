part of 'productview_bloc.dart';

abstract class ProductviewState extends Equatable {
  const ProductviewState();

  @override
  List<Object> get props => [];
}

class ProductviewInitial extends ProductviewState {}

class ProductViewLoading extends ProductviewState {}

class ProductIdsFetchFromCartSuccess extends ProductviewState {
  const ProductIdsFetchFromCartSuccess({required this.productIds});
  final List<String> productIds;

  @override
  List<Object> get props => [productIds];
}

class ProductViewError extends ProductviewState {
  const ProductViewError({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}
