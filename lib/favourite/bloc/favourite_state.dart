part of 'favourite_bloc.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteLoaded extends FavouriteState {
  FavouriteLoaded({required this.favouriteProducts});
  final Future<List<Product>> favouriteProducts;
}

class FavouriteError extends FavouriteState {
  FavouriteError({required this.error});
  final String error;
}
