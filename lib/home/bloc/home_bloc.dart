import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecomm/data/sharedprefs/shared_preference_helper.dart';
import 'package:ecomm/home/data/models/product.dart';
import 'package:ecomm/home/data/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.homeRepository) : super(HomeInitial()) {
    on<HomeEventFetch>(_fetchHomeProducts);
    on<HomeEventFavourite>(_updateFavouriteStatusOfProduct);
    on<HomeEventLogout>(_logOutUserFromApp);
  }
  final HomeRepository homeRepository;

  Future<void> _fetchHomeProducts(
    HomeEventFetch event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoading());
      final data = homeRepository.products;
      emit(HomeLoaded(products: data));
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }

  Future<void> _updateFavouriteStatusOfProduct(
    HomeEventFavourite event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await homeRepository
          .updateFavourite(
        event.id,
        event.context,
        isFavourite: event.isFavourite,
      )
          .then((value) {
        event.notifyUpdateIsFavourite();
      });
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }

  FutureOr<void> _logOutUserFromApp(
    HomeEventLogout event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      await homeRepository.logout();

      await SharedPreferences.getInstance().then((_prefs) async {
        await SharedPreferenceHelper(_prefs).setIsLoggedIn(isLoggedIn: false);
        await SharedPreferenceHelper(_prefs).setIsNewuser(isNewUser: false);
      }).then((value) {
        Navigator.pushNamedAndRemoveUntil(
          event.context,
          '/signin',
          (route) => false,
        );
      });
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }
}
