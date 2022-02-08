import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecomm/cart/data/model/cart_product.dart';
import 'package:ecomm/cart/data/repository/cart_repository.dart';
import 'package:ecomm/data/repository/app_repository.dart';
import 'package:ecomm/home/data/models/product.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required this.cartRepository, required this.appRepository})
      : super(CartInitial()) {
    on<CartProductFetchEvent>(_fetchCartProducts);
    on<CartProductQuantityChangedEvent>(_changeProductQuantity);
    on<CartProductDeleteEvent>(_deleteCartProduct);
  }
  final CartRepository cartRepository;
  final AppRepository appRepository;

  FutureOr<void> _fetchCartProducts(
    CartProductFetchEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      final cartProductIds = await cartRepository.fetchCartProductIds();
      final cartProducts = await cartRepository.fetchCartProduct(
        cartProductIds,
      );
      emit(CartLoaded(cartProducts: cartProducts));
    } catch (e) {
      emit(CartError(error: e.toString()));
    }
  }

  FutureOr<void> _changeProductQuantity(
    CartProductQuantityChangedEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      await cartRepository.updateCartProduct(
        event.product.id,
        event.quantity,
      );
      final cartProductIds = await cartRepository.fetchCartProductIds();
      final cartProducts = await cartRepository.fetchCartProduct(
        cartProductIds,
      );
      emit(CartLoaded(cartProducts: cartProducts));
    } catch (e) {
      emit(CartError(error: e.toString()));
    }
  }

  FutureOr<void> _deleteCartProduct(
    CartProductDeleteEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    await cartRepository
        .deleteCartProduct(
      event.id,
    )
        .then((_) async {
      final cartProductIds = await cartRepository.fetchCartProductIds();
      final cartProducts = await cartRepository.fetchCartProduct(
        cartProductIds,
      );
      emit(CartLoaded(cartProducts: cartProducts));
    });
  }
}
