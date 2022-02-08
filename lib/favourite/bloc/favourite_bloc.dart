import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecomm/favourite/data/repository/favourite_repository.dart';
import 'package:ecomm/home/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc(this.favouriteRepository) : super(FavouriteInitial()) {
    on<FavouriteEventFetch>(_fetchFavouriteProducts);
    on<FavouriteEventRemove>(_removeFavoriteProduct);
  }
  final FavouriteRepository favouriteRepository;

  FutureOr<void> _fetchFavouriteProducts(
    FavouriteEventFetch event,
    Emitter<FavouriteState> emit,
  ) {
    try {
      emit(FavouriteLoading());
      final favouriteProducts = favouriteRepository.fetchFavouriteProduct();
      emit(FavouriteLoaded(favouriteProducts: favouriteProducts));
    } catch (e) {
      emit(FavouriteError(error: e.toString()));
    }
  }

  FutureOr<void> _removeFavoriteProduct(
    FavouriteEventRemove event,
    Emitter<FavouriteState> emit,
  ) async {
    try {
      await favouriteRepository.deleteFavourite(
        productId: event.id,
        context: event.context,
      );
    } catch (e) {
      emit(FavouriteError(error: e.toString()));
    }
  }
}
